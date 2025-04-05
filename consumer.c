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
    shmdt(buf);
    printf("\nCleanup done by consumer.\n");
    exit(0);
}

int main() {
    signal(SIGINT, cleanup);

    // Attach to existing semaphores and memory
    semid = semget(SEMKEY, 3, 0666);
    shmid = shmget(SHMKEY, sizeof(circular_buffer), 0666);
    buf = (circular_buffer *)shmat(shmid, NULL, 0);

    int item;

    while (1) {
        sleep(2); // Simulează timp de consum

        semop(semid, &wait_sem(SEM_FULL), 1);  // wait(full)
        semop(semid, &wait_sem(SEM_MUTEX), 1); // wait(mutex)

        item = buf->buffer[buf->out];
        printf("Consumer: consumed %d from %d\n", item, buf->out);
        buf->out = (buf->out + 1) % BUFFER_SIZE;

        semop(semid, &signal_sem(SEM_MUTEX), 1); // signal(mutex)
        semop(semid, &signal_sem(SEM_EMPTY), 1); // signal(empty)
    }

    return 0;
}
