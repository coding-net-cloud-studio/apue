/*
 * 包含必要的头文件
 */
#include "apue.h"
#include <errno.h>

/*
 * 定义客户端请求字符串
 */
#define CL_OPEN "open" /* client's request for server */

/*
 * 声明外部函数 csopen,该函数用于与服务器建立连接并打开文件
 */
int csopen(char *, int);
