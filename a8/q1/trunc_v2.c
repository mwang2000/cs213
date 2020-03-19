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
    char** r = (char**) rv;
    int* a = (int*) av;
    char* b = (char*) bv;
    if (a != -1) {
        *r = NULL;
    } else {
        *r = b;
    }
}

int isPositive(element_t av) {
    int* a = (int*) av;
    return a!=-1;  
}

int isNotNull(element_t av) {
    char* a = (char*) av;
    return a != NULL;
}

void truncate(element_t* rv, element_t av, element_t bv) {
    char** r = (char**) rv;
    int* a = (int*) av;
    char* b = (char*) bv;
    // char* temp = strndup(b,a);
    // *r = temp;
    // free(temp);
    *r = strndup(b,a);
}

void print(element_t av) {
    char* a = (char*) av;
    if (a != NULL) {
    printf("%s\n", a);
    }
}

void findMax(element_t* rv, element_t av, element_t bv) {
  int** r = (int**) rv;
  int* a = (int*) av;
  int* b = (int*) bv;
  if (a >= b) {
    *r = a;
  } else {
    *r = b;
  }
}

void concatenate(element_t* vv, element_t av, element_t bv) {  
  char** v = (char**) vv;
  char* a = av;  
  char* b = bv;
  *v = realloc(*v, strlen(*v) + strlen(b) + 1);
  if (**v != 0) {
    strcat(*v," ");
  }
  strcat(*v, b);
  // strcat(*v," ");
}

int main(int argc, char* argv[]) {
    struct list* list = list_create();
    for (int i = 1; i < argc; i++) {
        list_append(list,(element_t)argv[i]);
    }

    struct list* listOfNum = list_create(); // list of numbers, -1 if list had a string 
    list_map1(parse_string,listOfNum, list);

    struct list* listOfNull = list_create(); // list of string, null if numbers
    list_map2(convertToNull,listOfNull,listOfNum,list);

    struct list* listOfPositives = list_create(); // filtered listOfNum
    list_filter(isPositive, listOfPositives, listOfNum);

    struct list* listOfNoNull = list_create(); // filtered listOfNull
    list_filter(isNotNull,listOfNoNull,listOfNull);

    struct list* result = list_create();
    list_map2 (truncate, result, listOfPositives,listOfNoNull);

    list_foreach(print,result);

    char* concat = malloc(1);
    *concat = 0;
    list_foldl(concatenate,&concat,result);
    printf("%s\n",concat);
    free(concat);

    element_t max = 0;
    list_foldl(findMax,&max,listOfPositives);
    printf("%d\n", max);

    list_foreach(free,result);

    list_destroy(list);
    list_destroy(listOfNum);
    list_destroy(listOfNull);
    list_destroy(listOfPositives);
    list_destroy(listOfNoNull);
    list_destroy(result);
}

