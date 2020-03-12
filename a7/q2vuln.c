#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct string {
    int length;
    char* chars;
} string;

string str1 = {30, "Welcome! Please enter a name: "};
string str2 = {11, "Good luck, "};
string str3 = {43, "The secret phrase is \"squeamish ossifrage\""};

void print(struct string str) {
    write(1,str.chars,str.length);
}

void proof() {
    print(str3);
}

int main() {
    char *buf[128];
    print(str1);
    int numchar = read(0,buf,256);
    print(str2);
    write(1,buf,numchar);
}
