#include "str_element.h"
#include "refcount.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "element.h"
#include "list.h"
#include "tree.h"

/* TODO: Implement all public str_element functions, including element interface functions.

You may add your own private functions here too. */

/* Forward reference to a str_element. You get to define the structure. */
struct str_element {
    struct element_class *class;
    char *i;
};

// void int_element_finalizer(void *e) {
// // struct int_element *temp = e;
// //    printf("%d\n", temp->i);
// // free(temp->i); 
// }

void str_element_print(void *thisv) {
  struct str_element *this = thisv;
  printf("%s\n", this->i);
}

int str_element_compare(void*thisv, void *thatv) {
    struct str_element *copy1 = thisv;
    struct str_element *copy2 = thatv;
    if (is_str_element(copy1) == 0 && is_str_element(copy2) == 1) {
        return -1;
    } else if (is_str_element(thisv) == 1 && is_str_element(thatv) == 1) {
        return strcmp(copy1->i, copy2->i);
    } else {
        return 1;
    }
}


struct element_class str_element_class = {str_element_print, str_element_compare};


void str_element_finalizer(void *ev) {
    struct str_element *e = ev;
    free(e->i);
}

/* Static constructor that creates new string elements. */
struct str_element *str_element_new(char *value){
    struct str_element *obj = rc_malloc(sizeof(struct str_element), str_element_finalizer);
    obj->class = &str_element_class;
    obj->i = strdup(value);
    return obj;
}

/* Static function that obtains the string from a str_element. The caller should keep_ref it. */
char *str_element_get_value(struct str_element *thisv){
  struct str_element *this = thisv;
  return this->i;
}


/* Static function that determines whether this is a str_element. */
int is_str_element(struct element *thisv){
    return(thisv->class == &str_element_class);
}
