#include "str_element.h"
#include <stdio.h>
#include <stdlib.h>
#include "refcount.h"

struct str_element {
    struct str_element_class* class;
    char* string;
};

struct str_element_class {
    void (*print) (void*);
    int (*compare) (void *, void *);
};

void str_element_print(void *thisv) {
    struct str_element *this = thisv;
    printf("%s\n",this->string);
}

int str_element_compare(void *this1, void *this2) {
    if (is_str_element(this1) == 0 && is_str_element(this2) == 1) {
        return -1;
    } else if (is_str_element(this1) == 1 && is_str_element(this2) == 1) {
        return strcmp(this1, this2);
    } else {
        return 1;
    }
}

struct str_element_class str_element_class = {str_element_print,str_element_compare};

struct str_element* str_element_new(char* s) {
    struct str_element* element = rc_malloc(sizeof(*element), str_element_finalizer);
    element->class = &str_element_class;
    element->string = s;
    return element; 
}

char *str_element_get_value(void* element) {
    struct str_element *str = element;
    return str->string;
}

int is_str_element(void* element) {
    struct str_element *str = element;
    if (str->class == &str_element_class) {
        return 1;
    } else {
        return 0;
    }
}

void str_element_finalizer(void *ev) {
    struct str_element *e = ev;
    free(e->string);
}