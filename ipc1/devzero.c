#include "apue.h"
#include <fcntl.h>
#include <sys/mman.h>

// 定义循环次数和共享内存区域的大小
#define NLOOPS 1000
#define SIZE   sizeof(long)

// 更新共享内存中的值,并返回更新前的值
/**
 * @param ptr 指向共享内存区域的指针
 * @return 更新前的值
 */
static int
update(long *ptr)
{
    return ((*ptr)++);  // 返回值在递增之前
}

int main(void)
{
    int   fd, i, counter;  // 文件描述符,循环计数器,计数器值
    pid_t pid;             // 进程ID
    void *area;            // 指向共享内存区域的指针

    // 打开/dev/zero设备文件,用于创建共享内存
    if ((fd = open("/dev/zero", O_RDWR)) < 0)
        err_sys("open error");
    // 映射共享内存区域
    if ((area = mmap(0, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0)) == MAP_FAILED)
        err_sys("mmap error");
    close(fd);  // 映射完成后关闭文件描述符

    TELL_WAIT();  // 初始化父子进程间的同步

    // 创建子进程
    if ((pid = fork()) < 0)
    {
        err_sys("fork error");
    }
    else if (pid > 0)
    {  // 父进程
        for (i = 0; i < NLOOPS; i += 2)
        {
            // 更新共享内存中的值,并检查是否与预期相符
            if ((counter = update((long *)area)) != i)
                err_quit("parent: expected %d, got %d", i, counter);

            TELL_CHILD(pid);  // 通知子进程可以继续执行
            WAIT_CHILD();     // 等待子进程完成
        }
    }
    else
    {  // 子进程
        for (i = 1; i < NLOOPS + 1; i += 2)
        {
            WAIT_PARENT();  // 等待父进程通知

            // 更新共享内存中的值,并检查是否与预期相符
            if ((counter = update((long *)area)) != i)
                err_quit("child: expected %d, got %d", i, counter);

            TELL_PARENT(getppid());  // 通知父进程可以继续执行
        }
    }

    exit(0);  // 退出进程
}
