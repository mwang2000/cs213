#include "int_element.h"
#include <stdio.h>
#include <stdlib.h>
#include "refcount.h"

struct int_element {
    struct int_element_class* class;
    int i;
};

struct int_element_class {
    void (*print)(void*);
    int (*compare) (void *, void *);
};

void int_element_print(void *thisv) {
    struct int_element *this = thisv;
    printf("%d", this->i);
}

 /* Compare two elements. int_element should always compare LESS than str_element.
   * The compare function should return:
   *   a number < 0 if the first element is less than the second element,
   *   0 if the elements compare equal,
   *   a number > 0 otherwise.
   */
int int_element_compare(void *this1, void *this2) {

    // 1. guard =
    // this1< this2
    // this1==this2
    // this1>this2

    // 1
    // if(is_int_element(this1)){

    // } else {return 1;}

    if (is_int_element(this1) == 1 && is_int_element(this2) == 0) {
        return -1;
    } else if (is_int_element(this1) == 1 && is_int_element(this2) == 1) {
        int x = this1->i;
        int y = this2->i;
        if (x==y) {
            return 0;
        } else if (x < y) {
            return -1;
        }
    } else {
        return 1;
    }
}

struct int_element_class int_element_class = {int_element_print,int_element_compare};

struct int_element* int_element_new(int i) {
    struct int_element* element = rc_malloc(sizeof (*element), NULL);
    element -> class = &int_element_class;
    element -> i = i;
    return element; 
}

int int_element_get_value(void *element) {
    struct int_element *int_ = element;
    return int_->i;
}

int is_int_element(void *element) {
    struct int_element *int_ = element;
    if (int_->class == &int_element_class) {
        return 1;
    } else {
        return 0;
    }
    // return element->class == &int_element_class
}

void int_element_finalizer(void *ev) {
    struct int_element *e = ev;
    free(e->i); 
}
