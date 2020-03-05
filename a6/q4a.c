#include <stdio.h>

int someA[10] = {0,0,0,0,0,0,0,0,0,0}; 
int *someP = someA; 

void func0x200(int arg1, int arg2) {
    someA[arg2] = arg1 + someA[arg2];
}

void func0x300(){
    int local1 = 1;
    int local2 = 2;
    func0x200(3, 4);
    func0x200(local1, local2);
}

int main(int argc, char** argv) {
  func0x300();
  printf("%d\n", someA[0]);
  printf("%d\n", someA[1]);
  printf("%d\n", someA[2]);
  printf("%d\n", someA[3]);
  printf("%d\n", someA[4]);
  printf("%d\n", someA[5]);
  printf("%d\n", someA[6]);
  printf("%d\n", someA[7]);
  printf("%d\n", someA[8]);
  printf("%d\n", someA[9]);
  return 0; 
} 