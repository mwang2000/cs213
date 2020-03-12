#include "int_element.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "element.h"
#include "list.h"
#include "tree.h"
#include "refcount.h"


/* TODO: Implement all public int_element functions, including element interface functions.

You may add your own private functions here too. */

/* Forward reference to a int_element. You get to define the structure. */

struct int_element_class {
    void(*print)(void*);    
    int(*compare)(struct element*, struct element*);
};

struct int_element {
    struct int_element_class *class;
    int i;
};

struct int_element* copy_int(void *thisv){
    struct int_element *this = thisv;
    return this;
}

void int_element_print(void *thisv) {
  struct int_element *this = thisv;
  printf("%d\n", this->i);
}

int int_element_compare(struct element *this1, struct element *this2) {
    if (is_int_element(this1) == 1 && is_int_element(this2) == 0) {
        return -1;
    } if (is_int_element(this1) == 1 && is_int_element(this2) == 1) {
        struct int_element *copy1 = copy_int(this1);
        struct int_element *copy2 = copy_int(this2);
        int x = copy1->i;
        int y = copy2->i;
        if (x==y) {
            return 0;
        } else if (x < y) {
            return -1;
        }
    } else {
        return 1;
    }

}


struct int_element_class int_element_class = {int_element_print, int_element_compare};


// void int_element_finalizer(void *e) {
// // struct int_element *temp = e;
// //    printf("%d\n", temp->i);
// // free(temp->i); 
// }



/* Static constructor that creates new integer elements. */
struct int_element *int_element_new(int value){
    struct int_element *obj = rc_malloc(sizeof(struct int_element), NULL);
    obj->class = &int_element_class;
    obj->i = value;
    return obj;
}

/* Static function that obtains the value held in an int_element. */
int int_element_get_value(struct int_element *thisv){
  struct int_element *this = thisv;
  return this->i;
}

// /* Static function that determines whether this is an int_element. */
int is_int_element(struct element * thisv){
    struct int_element *copy1 = copy_int(thisv);

    return(copy1->class == &int_element_class);
}
