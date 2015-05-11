## Depth First Search (single mobile agent)
This example demonstrates the implementation of a depth first search (DFS) algorithm in which a mobile agent explores a network graph in a dfs manner. The nodes of the graph correspond to different platforms in the network. Each platform conatins information about it's connectivity with other nodes in the form of predicates. The mobile agent moves from platform to platform and prints a message on every one of them while dropping any necessary information on the paltforms for later use (for example wether or not it has already visited the node and previous location). Each platform also has a stationary agent, which responds to queries made by the mobile agent (This is used by the mobile agent to test the status of nodes i.e visited or not visited). The process can be controlled interactively by the user.

### Usage
First we need to initialize the graph on the network.

0. Copy the Tartarus platform file into the directory of this example as `platform.pl` 

1. Open the SWI-Prolog interpreter or console in the directory of this example and run `consult('graph.pl').` (On windows systems this can be done directly by double clicking on the graph.pl icon in explorer window)

2. Run `init(1).` This will initialize the first node of the graph on this instance of prolog interpreter.

3. Repeat steps 1 and 2 four more times except run `init(2).` , `init(3).` and so on instead of `init(1).` (upto `init(5).`) (Note: each init must be executed on a spearate instantiation of swi prolog i.e. a new window or terminal)

4. Pick any one of the running platforms as the starting point and run `consult('start.pl').` in the corresponding window.

5. Run `init.` This will initialize the mobile agent.

6. Run `start.` This will start the dfs process.

7. Run `go.` This will execute the agent on this node and it will then move to it's next destination.

8. You can use `go.` on each of the platforms as the agent moves to control the process interactively.

9. When the process finishes, the agent will be back at the starting point and a `dfs finished` message will be printed

### Algorithm
When on a particular node the mobile agent works as follows:
* If the node is new (not yet visited) it carries out the operations to be done on a new node:
  - The hi message is printed
  - The node just before this is stored in the `previous` predicate (this will be useful for backtracking)
  - The node is marked as visited (by asserting the `visited` predicate on the platform)
* The mobile agent searches for an unvisited neighbour of this node. It does so by sending messages to the stationary agents on each of the neighbouring nodes. If any of the agents give a positive response (i.e. not yet visisted) the mobile agent simply moves to that node and the process continues.
* If there are no more unvisited neighbours (i.e dead end), the agent backtracks by moving to the location stored in the `previous` predicate.
* If the dead-end is the starting point the algorithm terminates with proper indication

(Note: At each step the node visited just before the present node is stored in a payload predicate `just_before`)

### Graph
The graph is contructed using predicates in the `graph.pl` file. To build a custom graph, this file can be modified. Details can be found in the inline comments of this file.
