#include <stdio.h>

/* @brief 打开数据文件并设置缓冲区 */
/* @return 成功返回文件指针,失败返回NULL */
FILE *
open_data(void)
{
    FILE *fp;              /*   文件指针 */
    char  databuf[BUFSIZ]; /*   设置缓冲区,BUFSIZ是stdio.h中定义的标准缓冲区大小 */

    /*   尝试以只读模式打开文件datafile
    if ((fp = fopen("datafile", "r")) == NULL)
        return (NULL);  /*   打开失败,返回NULL */

    /*   设置文件流的缓冲区为databuf,使用_IOLBF标志表示行缓冲,BUFSIZ是缓冲区大小 */
    if (setvbuf(fp, databuf, _IOLBF, BUFSIZ) != 0)
        return (NULL); /*   设置缓冲区失败,返回NULL */

    return (fp); /*   成功打开并设置缓冲区,返回文件指针 */
}
