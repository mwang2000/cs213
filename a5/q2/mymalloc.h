#pragma once

/* Interface to your implementation of malloc. DO NOT MODIFY THIS FILE. */

/* Initialize your memory manager to manage the given heap. */
void mymalloc_init(char *heap, int heapsize);

/* Allocate a block of memory of the given size, or NULL if unable.

Returns: a pointer aligned to 8 bytes, or NULL if allocation failed. */
void *mymalloc(int size);

/* Free the given block of memory. */
void myfree(void *ptr);
