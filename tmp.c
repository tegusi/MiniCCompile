//int getint(); // 前置函数声明，getint 函数是MiniC 内置函数，返回一个读入的整数
//int putchar(int c); // 内置函数，用于输出字符(参数为ascii 码)，返回值无意义
//// 注意！base 语法集不包括形如int putchar(int); 这种参数名没有具体给出的函数声明
//int putint(int i); // 内置函数，用于输出整数，返回值无意义
//int getchar(); // 内置函数，返回一个读入的字符的ascii 码(此程序未使用到该函数)
//int f(int x) /* 该函数以递归方式计算Fibonacci 数*/
//{
//    if (x < 2) /* if-else 语句*/
//        return 1;
//    else {
//        int y;
//        int z;
//        y = x - 1;
//        z = x - 2;
//        return f(y) + f(z); /* 递归函数调用*/
//    }
//}
//int g(int x) /* 该函数以数组和循环语句计算Fibonacci 数*/
//{
//    int a[40]; /* int 数组声明
//                注意！base 中数组大小必须是常数，不可写成int a[x]; 或int a[10+30]; 这样*/
//    a[0] = 1;
//    a[1] = 1;
//    int i;
//    i = 2; /* 注意！base 语法集不包括初始化赋值语句int i = 2; */
//    while (i < x + 1) /* while 循环是base 语法集唯一的循环语句*/
//    {
//        a[i] = a[i - 1] + a[i - 2];
//        i = i + 1;
//    }
//    return a[x];
//}
//int n; // 声明了一个全局变量
//int main() {
//    n = getint();
//    if (n < 0 || n > 30) /* 不带else 的if 语句*/
//        return 1;
//
//    t = g(n);
//    t = putint(t);
//    t = f(n);
//    t = putint(t);
//
//    return 0;
//}
//
//
int getint();
int putint(int x);
int printf(int a, int b, int c) {
    int o;
    o = putint(a);
    o = putint(b);
    o = putint(c);
    return 0;
}
int display(int array[100], int n)
{
    int i;
    int o;
    i = 1;
    while (i < n + 1) {
        int x;
        x = array[i];
        o = putint(x);
        i = i + 1;
    }
    return 1;
}
int quicksort(int array[100], int maxlen, int begin, int end)
{
    int i;
    int j;
    
    if(begin < end)
    {
        i = begin + 1;  // 将array[begin]作为基准数，因此从array[begin+1]开始与基准数比较！
        j = end;        // array[end]是数组的最后一位
        
        while(i < j)
        {
            if(array[i] > array[begin])  // 如果比较的数组元素大于基准数，则交换位置。
            {
                int t;
                t = array[i];
                array[i] = array[j];
                array[j] = t;
                j = j - 1;
            }
            else
            {
                i = i + 1;
            }
        }
        
        if(array[i] > array[begin] - 1)  // 这里必须要取等“>=”，否则数组元素由相同的值时，会出现错误！
        {
            i = i - 1;
        }
        
        int t;
        t = array[begin];
        array[begin] = array[i];
        array[i] = t;
        
        int o;
        o = quicksort(array, maxlen, begin, i);
        o = quicksort(array, maxlen, j, end);
        
        return 1;
    }
    else {
        return 1;
    }
}
int main()
{
    int n;
    int array[20];
    n = getint();
    int i;
    i = 1;
    while (i < n + 1) {
        array[i] = getint();
        i = i + 1;
    }
    
    int o;
    o = display(array, n);
    
    int st;
    st = 1;
    int ed;
    ed = n;
    o = quicksort(array, n, st, ed);  // 快速排序
    o = display(array, n);
    return 0;
}
