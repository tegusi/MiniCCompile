int n;
int tmp;
int getint();
int putint(int x);
int putchar(int x);
int f(int n)
{
    tmp = putint(n);
    n = 10;
    tmp = putchar(n);
    return 0;
}
int main()
{
    n = getint();
    if (n > 5) {
        int n;
        n = getint();
        tmp = f(n);
    }
    tmp = f(n);
    return 0;
}
