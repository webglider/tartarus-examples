###Aim:
Demonstrate mobile agents performing a BFS on a graph.

###AUTOMATIC INITIALIZATION:
0. Copy tartarus platform file as `platform.pl` into the directory of this example.

1. Start five intances of SWI-Prolog and consult `init_bfs.pl`.

   ```
   consult('init.pl').
   ```


2. Execute `init1` predicate on the platform where you want to start the BFS.

   ```
   init1.
   ```

3. Execute `init2`,`init3`,.... on the platforms remaining.(you can add extra `init`s as required by setting the corresponding ip,port in the init_bfs.pl).

4. Execute `start.` on the first platform to start the BFS.

### MANNUAL INITIALIZATION:
1. Copy tartarus platform file as `platform.pl` into the directory of this example.

2. First initialize the 'platform' and 'neighbors' predicate as follow:
  i. Assin a unique id to each platform ie IP, Port combination.
  ii. Based the size of the graph choose between writing a script or manually entering the neighbors     of each of       the platforms or nodes.


3. Run platforms and consult the 'bfs.pl' file using:

   ```
   [bfs.pl].
   or
   consult('bfs.pl').
   ```

4. Set a single token to each platform.Here in program we took it to be '9595'(in spawn predicate).

   ```			
   set_token(9595).
   ```

5. Now we have to choose a platform from which we wish to start the BFS and do the following:

  i. create an agent with some name say 'agent1' with handler 'spawn_agent_handler'.
     ```
     agent_create(agent1,(<hostIP>,<port>),spawn_agent_handler).
     ```
  ii. Add the token we have previously chosen for authentication (9595) to the agent.
							
      ```
      add_token(agent1,[9595]).
      ```
							

  iii. Add a payload to the agent containing the number of the layer of the node the agent is going to
       explore.Since this is the first node its layer is 0. (Note: Payload is a tool that enables us to attribute         predicates to a mobile agent ie when a predicate is added as a payload to the agent it is added to the code        the mobile agent thus travelling with it where ever it goes.)
	```
	assert(layer_number(guid,0)).
	add_payload(agent1,[(layer_number,2)]).
	```
   iv. Now execute the agent on the platform.
	```
	agent_execute(agent1,(<hostIP>,<port>),spawn_agent_handler).
	```
6. This now spawns agents through out the graph in similar fashion to breadth first search.



### How This works:
1. Agent1 executes and the handler `spawn_agent_handler` is called,which checks if the platform in which it is present is visited or not.

2. If the platform is already visited, it will simply kill it self.

3. If the platform is newly visited, it marks the the platform as visited using `visited` predicate and spawn new agents to the neighbors of the platform in which it is present.

4. After a new agent reaches its destination platform it again executes its code which is again handled by the `spawn_agent_handler` and the process repeats there after.

