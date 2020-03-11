#include <unistd.h>

struct string {
    int length;
    char* chars;
}

void main() {
    char buf[128];
    char str1;
    char str2;
    print(str1);
    read(0,buf,256);
    print(str2);
    write(1,buf,0);
}

void print(string str) {
    write(1,str[1],str[0]);
}

void proof() {
    print(str3);
}