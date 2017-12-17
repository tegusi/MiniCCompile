int a[100];
int c;
int getint();
int putint(int x);
int printf(int a, int b, int c) {
  int o;
  o = putint(a);
  o = putint(b);
  o = putint(c);
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
