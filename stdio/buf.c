#include "apue.h"

// 打印stdio的相关信息,包括文件描述符,缓冲类型和缓冲区大小
// 参数:description - 描述信息的字符串,stream - 文件流指针
void pr_stdio(const char *description, FILE *stream);

// 判断给定的文件流是否是无缓冲的
// 参数:stream - 文件流指针
// 返回值:如果文件流是无缓冲的,则返回非零值;否则返回零
int is_unbuffered(FILE *stream);

// 判断给定的文件流是否是行缓冲的
// 参数:stream - 文件流指针
// 返回值:如果文件流是行缓冲的,则返回非零值;否则返回零
int is_linebuffered(FILE *stream);

// 获取给定文件流的缓冲区大小
// 参数:stream - 文件流指针
// 返回值:文件流的缓冲区大小,如果出错则返回-1
int buffer_size(FILE *stream);

// main.c

/**
 * 主函数,程序入口点.
 *
 * @return int 程序退出状态码
 */
int main(void)
{
    // 定义文件指针
    FILE *fp;

    // 向标准输出打印提示信息
    fputs("enter any character\n", stdout);

    // 读取用户输入的字符,如果遇到文件结束符EOF,则调用err_sys函数报告错误
    if (getchar() == EOF)
        err_sys("getchar error");

    // 向标准错误输出打印信息
    fputs("one line to standard error\n", stderr);

    // 打印标准输入,标准输出和标准错误的信息
    pr_stdio("stdin", stdin);
    pr_stdio("stdout", stdout);
    pr_stdio("stderr", stderr);

    // 尝试打开/etc/passwd文件,如果失败则调用err_sys函数报告错误
    if ((fp = fopen("/etc/passwd", "r")) == NULL)
        err_sys("fopen error");

    // 从打开的文件中读取一个字符,如果遇到文件结束符EOF,则调用err_sys函数报告错误
    if (getc(fp) == EOF)
        err_sys("getc error");

    // 打印/etc/passwd文件的信息
    pr_stdio("/etc/passwd", fp);

    // 正常退出程序
    exit(0);
}

// pr_stdio 函数用于打印文件流的缓冲状态和缓冲区大小
// 参数:
//   name: 文件流的名称
//   fp: 文件流指针
void pr_stdio(const char *name, FILE *fp)
{
    // 打印文件流的名称
    printf("stream = %s, ", name);

    // 判断文件流是否是无缓冲的
    if (is_unbuffered(fp))
        printf("unbuffered");
    // 判断文件流是否是行缓冲的
    else if (is_linebuffered(fp))
        printf("line buffered");
    // 如果既不是无缓冲也不是行缓冲,则认为是全缓冲
    else /* if neither of above */
        printf("fully buffered");

    // 打印文件流的缓冲区大小
    printf(", buffer size = %d\n", buffer_size(fp));
}
/*
 * 以下代码是非可移植的.
 */

// 判断文件流是否未缓冲
// 参数: fp - 文件流指针
// 返回: 如果文件流未缓冲,返回非零值;否则返回0
int is_unbuffered(FILE *fp);

// 判断文件流是否行缓冲
// 参数: fp - 文件流指针
// 返回: 如果文件流行缓冲,返回非零值;否则返回0
int is_linebuffered(FILE *fp);

// 获取文件流的缓冲区大小
// 参数: fp - 文件流指针
// 返回: 缓冲区大小,如果无法确定则返回BUFSIZ
int buffer_size(FILE *fp);

// 根据不同的平台定义,实现上述函数
#if defined(_IO_UNBUFFERED)
// ...(省略具体实现,保持原有代码不变)
#elif defined(__SNBF)
// ...(省略具体实现,保持原有代码不变)
#elif defined(_IONBF)
// ...(省略具体实现,保持原有代码不变)
#else
// 如果stdio实现未知,则抛出编译错误
#error unknown stdio implementation!
#endif
