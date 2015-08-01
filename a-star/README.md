## A* search
Imagine a network of roads in a busy city arranged in a square grid-like fashion. Each junction acts as a node and has infrastructure which connects to a digital network spread over the entire area. A vehicle would like to travel from a particular source node to a destination node. Since the city is usually very busy, there is a lot of traffic congestion and certain junctions end up having huge traffic jams. The vehicle driver would like to avoid traversing such jammed nodes during his journey. To find the shortest path from source to destination avoiding jammed nodes, a mobile-agent is spawned at the source. The agent looks for the destination using the well known A* graph search algorithm. Once it reaches the goal it spawns another mobile agent which retraces the shortest path from source to destination.

| Filename      | Purpose                                                           |
| --------      | ----------------------------------------------------------------- |
| conf.pl       | Configuration Information                                         |
| explorer.pl   | Agent performing A*                                               |
| updater.pl    | Agent for performing updates on other platforms                   |
| tracer.pl     | Agent which traces back the shortest path                         |
| init.pl       | To initialize platforms and other information on all nodes        |
| setup.pl      | Setup script which creates instances and runs init on all of them |


### Algorithm
Three types of mobile agents are used in this example.

* Explorer Agent (explorer.pl)

* Updater Agent (updater.pl)

* Tracer Agent (tracer.pl)

The most complex of all is the Explorer, which essentially traverses the network graph using the A* algorithm. When at a particular node, if the status or information at a neighbouring node needs to be updated, it spawns lightweight Updater Agent to achieve the task. Updaters kill themselves immediately after the data has been added to the target node. Once the Explorer reaches the goal, it spawns executes a Tracer, which simply re-traces the path back to the source, and reports the result at the source


### Usage

Basic setup
________

1. Open the `conf.pl` file and edit the `path_to_tartarus` predicate to point to the location of the Tartarus `platform.pl` in your system.


Setup of platforms
___________________

Since the number of platforms could get large, we have included a setup script `setup.pl` to ease the setup process

1. Open `conf.pl` file and edit the `swipl_command` predicate, replacing the string in quotes with the format of the command to be used to open a new instance of swi prolog. The usual format for both linux and windows systems is mentioned in the comments of the file. The `<command>` part of the string will be replaced with the appropriate command by the setup script, during the setup process. (no need to worry about this)

2. In the same file you can also edit the `base_port` predicate. If base_port is 7000 then platforms will be created from 7000, 7001 and so on... 

3. Open an instance of swi prolog and consult `setup.pl`.

4. Run `setup.` The platforms will be created and automatically setup :)


Finding Shortest Path
_____________________

1. Open the source platform (7001 if 7000 was base port) and run `start.` The entire process will execute and the shortest path will be printed as a list of directions to follow (north, south, east, west)


**Note:** In the example grid start platform is at north-west top and target platform is at south-east bottom

One can move in only the directions North, South ,East, West

![example grid](https://raw.githubusercontent.com/webglider/tartarus-examples/master/a-star/grid.png "Grid in Example")


### Additional Notes

* You can modify the grid size using the `grid_size` predicate in `conf.pl`

* The nodes which are jammed are specified by the `jammed_node` predicate in `conf.pl`. You are free to play around with these and observe different paths




  
