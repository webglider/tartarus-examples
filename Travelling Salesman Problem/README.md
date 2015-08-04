## Travelling Salesman Problem
A salesman want to popularize his products all over France. To do so he decides to tour 5 major cities in France one after another. He would like to take the tour of least total distance passing through each of the cities exactly once. This is an instance of the classic Travelling Salesman Problem (TSP). In this example we emulate this scenario with the salesman as an intelligent mobile agent and each of the cities as a tartarus platform in the network. The salesman can move from city to city, and can obtain information of which city is at what distance while at a particular city. This distance information is stored locally on the platforms of the cities. Further the salesman carries a checklist along with him as payload, which he uses to make sure he does not visit a city twice. The TSP problem being NP Hard cannot be solved efficiently and hence we use a simple heuristic, the Nearest Neighbour (NN) heuristic. At any given city the salesman moves on to an unvisited city which is at least distance from his present location.

### Log Server
This example introduces the log server feature. A log server is an independently running Tartarus platform which can be used to log various agent actions on different platforms.

Creating a Log server is as simple as creating a normal Tratarus platform `platform_start(host, port)`.
To send log messages to this platform from a different platform, the `set_log_server(host, port).` predicate must be used, where host and port correspond to that of the log server's platform. 
Once the log server is set, messages can be simply sent using `send_log(agent_name, message)`. The messages are neatly logged with timestamps and source information.

### Usage
Each city is essentially a tartarus platform. The `city*.pl` files will automatically set up the platforms for this example.

Basic setup
________

1. Open the `conf.pl` file and edit the `path_to_tartarus` predicate to point to the location of the Tartarus `platform.pl` in your system.

2. The `locations.pl` file assigns each city a unique host and port pair. Platforms will be created according to these details. You are free to modify the hosts and ports in this file


Setup of Log server
___________________

Log server is used to keep track of the agent's movements. Whenever the salesman reaches a new city the log server platform will get a message

1. Open `conf.pl` and edit the `log_server_details` providing a Host and Port of your desire.

2. Run an instance of SWI-Prolog (swipl), and consult the `platform.pl` files using `consult('path to platform.pl').` or the Windows GUI.

3. Start a platform with `platform_start(Host, Port).` where Host and Port are the ones chosen just above.

Setup of cities
_______________

1. Open 5 instances of SWI-prolog (swipl) and consult `city1.pl` to `city5.pl`, one on each of them.

2. Execute `init.` on all the platforms.


Setup of salesman
_______________________

1. Choose any city to start from and open it's corresponding platform (city name is printed in each platform during initialization).

2. `consult('salesman.pl').` on this platform.

3. Execute `start.` and watch the log server.

### Distance data used in example

| City      |  Paris  |  Nice  |  Lyon  | Grenoble | Marseille |
| --------- | ------- | ------ | ------ | -------- | --------- |
| Paris     |    0    |  927   |  457   |  566     |  769      |
| Nice      |   927   |   0    |  471   |  334     |  185      |
| Lyon      |   457   |  471   |   0    |  105     |  314      |
| Grenoble  |   566   |  334   |  105   |  0       |  273      |  
| Marseille |   769   |  185   |  314   |  273     |  0        |

### Additional Notes
* The distance information can be found in the `city*.pl` files in the `price` predicates. Real-life values have been used for this example.

* To add a new city and extend this example you can do the following :
  
  1. Make a copy of `city1.pl` and edit the file giving it a proper `name`.

  2. Edit the distance information as required in the `price` predicates.

  3. Add a `price` predicate in each of the other `city*.pl` files telling the distance to the new city.

  4. Add the city to the salesman's `checklist` in the `salesman.pl` file

  5. Add the city with desired host and port to the `locations.pl` file

  6. Open a new SWI-prolog instance, consult this new prolog file and run `init.`
  
