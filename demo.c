int getint(); // 前置函数声明，getint 函数是MiniC 内置函数，返回一个读入的整数
int putchar(int c); // 内置函数，用于输出字符(参数为ascii 码)，返回值无意义
// 注意！base 语法集不包括形如int putchar(int); 这种参数名没有具体给出的函数声明
int putint(int i); // 内置函数，用于输出整数，返回值无意义
int getchar(); // 内置函数，返回一个读入的字符的ascii 码(此程序未使用到该函数)
int f(int x) /* 该函数以递归方式计算Fibonacci 数*/
{
if (x < 2) /* if-else 语句*/
return 1;
else {
    int y;
    int z;
    y = x - 1;
    z = x - 2;
    return f(y) + f(z); /* 递归函数调用*/
}
}
int g(int x) /* 该函数以数组和循环语句计算Fibonacci 数*/
{
int a[40]; /* int 数组声明
注意！base 中数组大小必须是常数，不可写成int a[x]; 或int a[10+30]; 这样*/
    a[0] = 1;
    a[1] = 1;
int i;
i = 2; /* 注意！base 语法集不包括初始化赋值语句int i = 2; */
while (i < x + 1) /* while 循环是base 语法集唯一的循环语句*/
{
a[i] = a[i - 1] + a[i - 2];
i = i + 1;
}
return a[x];
}
int n; // 声明了一个全局变量
int main() {
n = getint();
if (n < 0 || n > 30) /* 不带else 的if 语句*/
return 1;

n = g(n);
n = putint(n);
n = f(n);
n = putint(n);

return 0;
}
