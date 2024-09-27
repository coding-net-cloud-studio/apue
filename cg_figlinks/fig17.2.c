#include "apue.h"
#include <sys/socket.h>

/*
 * 返回一个全双工管道(一个 UNIX 域套接字),
 * 两个文件描述符分别在 fd[0] 和 fd[1] 中返回.
 */
int fd_pipe(int fd[2])
{
    return (socketpair(AF_UNIX, SOCK_STREAM, 0, fd));
}
