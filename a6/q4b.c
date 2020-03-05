#include <stdio.h>

int x[8] = {1,2,3,-1,-2,0,184,340057058}; 
int y[8] = {0,0,0,0,0,0,0,0}; 

int f(int arg1) {
    int toReturn = 0;
    for (arg1; arg1 != 0; arg1--) {
        if (arg1 & 0x80000000) {
            toReturn++;
        }
        arg1 = arg1 << 1;
    }
}

int main() {
  for (int count1 = 8; count1 > 0; count1--) {
      y[count1] = f(x[count1]); 
  }
  printf("%d\n", x[0]);
  printf("%d\n", x[1]);
  printf("%d\n", x[2]);
  printf("%d\n", x[3]);
  printf("%d\n", x[4]);
  printf("%d\n", x[5]);
  printf("%d\n", x[6]);
  printf("%d\n", x[7]);

  printf("%d\n", y[0]);
  printf("%d\n", y[1]);
  printf("%d\n", y[2]);
  printf("%d\n", y[3]);
  printf("%d\n", y[4]);
  printf("%d\n", y[5]);
  printf("%d\n", y[6]);
  printf("%d\n", y[7]);
  return 0; 
} 
