%% This file contains all the predicates for handling the `explorer` mobile agent.
%% This agent is meant to move through nodes in the network graph in a dfs manner.
%% The agent also sends messages to stationary agents on other platforms to get information.
:-dynamic dfs_handler/3.

dfs_handler(guid, (IP, Port), main) :- 
    writeln('explorer has arrived!').

%% Actual execution of agent on a given node
%% This will be called when `move` is executed by the user. 
dfs_handler(guid, (IP, Port), execute) :- 
    %% Check if this node has already been visited
    (visited(guid) ->
        nothing 
    ;
        %% The agent has arrived at a new node (not yet visited)
        %% Execute actions to be done on a new node
        dfs_handler(guid, (IP,Port), new_node)
    ),
    writeln('check visited'),
    %% Find the next node
    %% `checklist` is used to keep track of nodes which have already been checked
    assert(checklist(guid, none)),
    writeln('asserted checklist'),
    dfs_handler(guid, (IP,Port), find_next).

%% Actions to be done when new node is reached
dfs_handler(guid, (_,_), new_node) :- 
    writeln('Hi my name is explorer and I am exploring this network'),
    just_before(guid, X), assert(previous(guid, X)),
    assert(visited(guid)).

%% Agent looks for the next node to move to
%% it does so by sending a message to the stationary agents on neighbouring nodes
%% This is to ensure it does not move to an already visited node
dfs_handler(guid, (IP,Port), find_next) :-
    %% pick a neighbour not on the checklist
    (neighbour(Node),not(checklist(guid, Node)) ->
        %% send message to stationary agent on node requesting for status
        writeln('sending message...'), writeln(Node), writeln(IP), writeln(Port),
        agent_post(platform, Node, [node_handler, stationary, (IP,Port), get_status(guid)])
    ;
        %% Dead-end has been reached
        previous(guid, Destination),
        dfs_handler(guid, (IP,Port), move(Destination))
    ).
    

%% Moving the agent to given Destination
%% Sets the `just_before` payload
dfs_handler(guid, (IP,Port), move(Destination)) :-
    (Destination=none -> writeln('dfs complete') 
        ;
        retract(just_before(guid, _)), assert(just_before(guid, (IP,Port))),
        agent_move(guid, Destination)
    ).   

%% When a good response is recieved the agent simply moves to the 
%% corresponding node.
dfs_handler(guid, (Sender_IP, Sender_Port), response_good) :-
    %% Move the agent.
    get_platform_details(IP, Port),
    dfs_handler(guid, (IP,Port), move((Sender_IP,Sender_Port))).

%% When a bad response is recieved, the agent looks for other neighbouring nodes.
dfs_handler(guid, Sender, response_bad) :-
    %% add the sender to the checklist
    assert(checklist(guid, Sender)),
    %% Look for another 
    get_platform_details(IP, Port),
    dfs_handler(guid, (IP,Port), find_next).
