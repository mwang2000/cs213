#include <stdlib.h>

#include <stdio.h>

#include <stdint.h>

#include <string.h>

#include "list.h"

void parse_string(element_t* rv, element_t av) {
  char *a = (char*) av;
  int** r = (int**) rv;
  char* endp;
  long value = strtol(a, &endp, 10);
  if(a[0] != '\0' && endp[0] == '\0') {
    *r = (int*)value;
  } else {
    *r = -1;
  }
}

void convertToNull(element_t* rv, element_t av, element_t bv) {
    int* a = (int*) av;
    char* b = (char*) bv;
    char** r = (char**) rv;
    if (*a != -1) {
        *r = NULL;
    } else {
        *r = b;
    }
}

int isPositive(element_t av) {
    int* a = (int*) av;
    return a>=0;  
}

int isNotNull(element_t av) {
    char* a = (char*) av;
    return a != NULL;
}

void truncate(element_t* rv, element_t av, element_t bv) {
    char** r = (char**) rv;
    char* a = (char*) av;
    int* b = (int*) bv;
    if (strlen(a) > *b) {
        a[*b] = 0;
    }
    *r = a;
}

void print(element_t av) {
    char* a = (char*) av;
    printf("%s\n", a);
}

void findMax(element_t* rv, element_t av, element_t bv) {
  int** r = (int**) rv;
  int* a = (int*) av;
  int* b = (int*) bv;
  if (a > b) {
    *r = a;
  } else {
    *r = b;
  }
}

int main(int argc, char* argv[]) {
    printf("a");
    struct list* list = list_create();
    for (int i = 1; i < argc; i++) {
        list_append(list,(element_t)argv[i]);
    }
    struct list* listOfNum = list_create();
    list_map1(parse_string,listOfNum, list);

    struct list* listOfNull = list_create();
    list_map2(convertToNull,listOfNull,listOfNum,list);

    struct list* listOfPositives = list_create();
    list_filter(isPositive, listOfPositives, listOfNum);

    struct list* listOfNoNull = list_create();
    list_filter(isNotNull,listOfNoNull,listOfNull);

    struct list* result = list_create();
    list_map2 (truncate, result, listOfPositives,listOfNoNull);

    list_foreach(print,result);
    element_t max;
    list_foldl(findMax,&max,listOfNum);
    printf("%d\n", max);

    list_destroy(list);
    list_destroy(listOfNum);
    list_destroy(listOfNull);
    list_destroy(listOfPositives);
    list_destroy(listOfNoNull);
    list_destroy(result);
}

