//Jakub Ogrodowczyk 26.10.2021
//zrobione

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

int main()
{
    int n;

    scanf("%d",&n);

    assert(n > 0);

    double srednia,x;
    for(int i = 0; i < n; i++)
    {
        scanf("%lf",&x);
        srednia += x/(float)n;
    }

    printf("%f\n",srednia);
    return 0;
}
