#Agent traversal in a Binary Search Tree

The binary search tree is defined by the `children` predicate as follows:

![BST image]
(graph.png)

The ports are assigned to unique platform ids through `platform` predicate.

`start(X)` predicate initializes platform number `X` and sets token.

`value_at(P_id,X)` gives the value `X` on platform `P_id`.


#How to run

1. `start(X)` on each of the terminal windows initializing platform number `X`.
2. `spawn(X)` on the root platform where `X` is the number we are searching for.

