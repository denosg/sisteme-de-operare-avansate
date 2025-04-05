#include "common.h"

int semid, shmid;
circular_buffer *buf;

struct sembuf wait_sem(int sem_num) {
    return (struct sembuf){ .sem_num = sem_num, .sem_op = -1, .sem_flg = 0 };
}

struct sembuf signal_sem(int sem_num) {
    return (struct sembuf){ .sem_num = sem_num, .sem_op = 1, .sem_flg = 0 };
}

void cleanup(int sig) {
    shmctl(shmid, IPC_RMID, NULL);
    semctl(semid, 0, IPC_RMID);
    printf("\nCleanup done by producer.\n");
    exit(0);
}

int main() {
    signal(SIGINT, cleanup);

    // Create semaphores
    semid = semget(SEMKEY, 3, IPC_CREAT | 0666);
    semctl(semid, SEM_MUTEX, SETVAL, 1);          // mutex
    semctl(semid, SEM_EMPTY, SETVAL, BUFFER_SIZE); // empty
    semctl(semid, SEM_FULL, SETVAL, 0);           // full

    // Create shared memory
    shmid = shmget(SHMKEY, sizeof(circular_buffer), IPC_CREAT | 0666);
    buf = (circular_buffer *)shmat(shmid, NULL, 0);
    buf->in = 0;
    buf->out = 0;

    int item = 0;

    while (1) {
        sleep(1); // Simulează timp de producere

        semop(semid, &wait_sem(SEM_EMPTY), 1); // wait(empty)
        semop(semid, &wait_sem(SEM_MUTEX), 1); // wait(mutex)

        // Scrie în buffer
        buf->buffer[buf->in] = item;
        printf("Producer: produced %d at %d\n", item, buf->in);
        buf->in = (buf->in + 1) % BUFFER_SIZE;
        item++;

        semop(semid, &signal_sem(SEM_MUTEX), 1); // signal(mutex)
        semop(semid, &signal_sem(SEM_FULL), 1);  // signal(full)
    }

    return 0;
}
