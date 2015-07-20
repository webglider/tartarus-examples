#Agent traversal in a Binary Search Tree

The binary search tree is defined by the `children` predicate as follows:

![BST image]
(graph.png)

#Predicates on platforms

The ports are assigned to unique platform ids through `platform` predicate.

`start(X)` predicate initializes platform number `X` and sets token.

`value_at(P_id,X)` gives the value `X` on platform `P_id`.

#Payload predicates

`spawn(X)`  asserts `search_value(X)` on the root then creates and agent and adds `search_value` as payload

#How to run

1. `start(X)` on each of the terminal windows initializing platform number `X`.
2. `spawn(X)` on the root platform where `X` is the number we are searching for.

