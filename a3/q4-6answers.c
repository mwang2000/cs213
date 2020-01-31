#include <stdio.h>
#include <stdlib.h>

int main() {
    int a[10] = {0,1,1,2,3,5,8,13,21,34};

    int *ans1;
    int ans2;
    int *ans3;

    ans1 = *(a+3);
    ans2 = &a[7] - &a[2];
    ans3 = *(a + (&a[7]-a+2));

    printf("ans1 = %d \n", ans1);
    printf("ans2 = %d \n", ans2);
    printf("ans3 = %d \n", ans3);
}



