#include <stdlib.h>
#include <stdio.h>

/**
 * A node of the binary tree containing the node's integer value
 * and pointers to its right and left children (or null).
 */
struct Node {
  int val;
  struct Node *leftChild;
  struct Node *rightChild;
};

/**
 * Create a new node with no children.
 */
struct Node* create (int value) {
  struct Node* newNode = (struct Node*) malloc(sizeof(struct Node));
  newNode->val = value;
  newNode->leftChild = 0;
  newNode->rightChild = 0;
  return *newNode;
}

/**
 * Insert the node n into the binary tree rooted by toNode.
 */
void insert (struct Node* toNode, struct Node* n) {
  if (n->val <= noTode->val) {
    if (toNode->leftChild == 0) {
      toNode->leftChild = n->val;
    }
    else {
      leftChild.insert(toNode, n);
    }
   
  }
  else {
    if (toNode->rightChild == 0) {
      toNode->rightChild = n->val;
    }
    else {
      rightChild.insert(toNode, n);
    }
  }
}

/**
 * Print the contents entire binary tree in order of ascending integer value.
 */
void printInOrder (struct Node* node) {
  if (left != 0)
    node->leftChild.printInOrder(node);
    out.printf ("%d\n", value);
  if (right != 0)
    node.rightChild.printInOrder(node);
  }
    
}

/**
 * Create a new tree populated with values provided on the command line and
 * print it in depth-first order.
 */
int main (int argc, char* argv[]) {
  // read values from command line and add them to the tree
  for (int i=1; i<argc; i++) {
    int value = atoi (argv [i]);
    printf ("%d\n", value);
  }
  // TODO
}