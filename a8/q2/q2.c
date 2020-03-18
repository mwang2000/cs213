#include <stdio.h>
#include <stdlib.h>

int q2(int a, int b, int c) {
    int r3 = -10;
    switch (r3+a) {
        case 0:  
            c = c + b; 
            break;
        case 1:  
            c = 0; 
            break;
        case 2:  
            c = b - c; 
            break;
        case 3:  
            c = 0; 
            break;
        case 4:  
            if (b > c) {
                c = 1;
            } else {
                c = 0;
            }
            break;
        case 5:  
            c = 0; 
            break;
        case 6:  
            if (c > b) {
                c = 1;
            } else {
                c = 0;
            } 
            break;
        case 7:  
            c = 0; 
            break;
        case 8:  
            if (c == b) {
                c = 1;
            } else {
                c = 0;
            }
            break;
        default:  
            c = 0;
  }
  return c;
}

int main() {
    int testArray[4];
    testArray[0] = 17;
    testArray[1] = 1; 
    testArray[2] = 1;
    testArray[3] = 0;
    testArray[3] = q2(testArray[0], testArray[1], testArray[2]);
    printf("%d\n", testArray[3]);

    testArray[0] = 18;
    testArray[1] = 2; 
    testArray[3] = q2(testArray[0], testArray[1], testArray[2]);
    printf("%d\n", testArray[3]);

    testArray[1] = 18;
    testArray[2] = 18; 
    testArray[3] = q2(testArray[0], testArray[1], testArray[2]);
    printf("%d\n", testArray[3]);

    testArray[0] = 1;
    testArray[1] = 2; 
    testArray[3] = q2(testArray[0], testArray[1], testArray[2]);
    printf("%d\n", testArray[3]);

}