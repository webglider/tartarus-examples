#Agent traversal in a Binary Search Tree

The binary search tree is defined by the `children` predicate as follows:

![BST image]
(graph.png)

#Predicates on platforms

The ports are assigned to unique platform ids through `platform` predicate.

`start(X)` predicate initializes platform number `X` and sets token.

`value_at(P_id,X)` gives the value `X` on platform `P_id`.

NOTE:
Every platform has information belonging ONLY to itself ie. `children(P,L,R)` and `value_at(X)` are asserted individually on each platform 

#Payload predicates

`spawn(X)`  asserts `search_value(X)` on the root then creates and agent and adds `search_value` as payload

#How to run

1. Execute the following command  from terminal `swipl -s bstinit.pl -g 'start(X)'` 
2. Or double click the `bstinit.pl` file and type `start(X)` on each of the instance for initializing platform number `X`.
3. Execute `spawn(X)` on the root platform where `X` is the number we are searching for.
4. A popup window appears for 3 seconds each time the spawned agent moves to a new platform and displays the value its searching for and the value it found.

#How it works
1. `start(X)` initializes the platform and asserts 
         (i) The children of the current platform only.
        (ii) The value on the platform.
2. `spawn_agent(X)` creates an agent with the name `scout` and adds as payload the value it is searching for `X`
3. If the `search_value` and `value_at` the platform are equal the program terminates with a note on the screen saying it has found the value its searching for.
4. If the `search_value` is greater agent moves to the left child platform.
5. If the `search_value` is lesser agent moves to the right child platform.
6. For moving `bst_handler(_ , _ , move_to(P))` is used which prints `Value NOT FOUND` message if there is no child  platform is present in the direction (left or right) specified thus guaranteeing the termination in case agent doesn't find the required value.
7. If a child is indeed present in the direction specified, the agent is moved using `agent_move`.

