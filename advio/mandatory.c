#include "apue.h"
#include <errno.h>
#include <fcntl.h>
#include <sys/wait.h>

int main(int argc, char *argv[])
{
    int         fd;       // 文件描述符
    pid_t       pid;      // 进程ID
    char        buf[5];   // 缓冲区
    struct stat statbuf;  // 文件状态结构体

    // 检查命令行参数数量
    if (argc != 2)
    {
        fprintf(stderr, "usage: %s filename\n", argv[0]);
        exit(1);
    }
    // 打开文件,如果不存在则创建,如果存在则截断
    if ((fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC, FILE_MODE)) < 0)
        err_sys("open error");
    // 写入数据到文件
    if (write(fd, "abcdef", 6) != 6)
        err_sys("write error");

    // 修改文件状态,设置set-group-ID位,清除group-execute位
    if (fstat(fd, &statbuf) < 0)
        err_sys("fstat error");
    if (fchmod(fd, (statbuf.st_mode & ~S_IXGRP) | S_ISGID) < 0)
        err_sys("fchmod error");

    TELL_WAIT();  // 通知子进程等待父进程的操作

    // 创建子进程
    if ((pid = fork()) < 0)
    {
        err_sys("fork error");
    }
    else if (pid > 0)
    { /* 父进程 */
        // 对整个文件加写锁
        if (write_lock(fd, 0, SEEK_SET, 0) < 0)
            err_sys("write_lock error");

        TELL_CHILD(pid);  // 通知子进程可以继续

        // 等待子进程结束
        if (waitpid(pid, NULL, 0) < 0)
            err_sys("waitpid error");
    }
    else
    {                   /* 子进程 */
        WAIT_PARENT();  // 等待父进程加锁完成

        set_fl(fd, O_NONBLOCK);  // 设置文件描述符为非阻塞模式

        // 尝试对已加锁的区域加读锁,预期失败
        if (read_lock(fd, 0, SEEK_SET, 0) != -1) /* no wait */
            err_sys("child: read_lock succeeded");
        printf("read_lock of already-locked region returns %d\n",
               errno);

        // 尝试读取文件,预期因强制锁而失败
        if (lseek(fd, 0, SEEK_SET) == -1)
            err_sys("lseek error");
        if (read(fd, buf, 2) < 0)
            err_ret("read failed (mandatory locking works)");
        else
            printf("read OK (no mandatory locking), buf = %2.2s\n",
                   buf);
    }
    exit(0);
}
