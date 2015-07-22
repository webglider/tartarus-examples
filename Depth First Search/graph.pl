%% This file contains all information and predicates to build the network graph

%% Each of the `init` predicates is meant to initialize a particular node of the graph on the network
%% Each of the `init` predicates must be called on a separate instantiation of prolog (either on same host or different)
%% The IP and Port in each `init` should be set accordingly
%% Each node will have a tartarus platform running on it along with some predicates to specify it's 
%% connectivity with other nodes and status of the node with respect to agents (visited or not visited)

%% This is a simple graph with 4 nodes arranged in the form of a diamond with an extra node connected to one of them.
:-dynamic visited/1.


%% Predicate to create stationary agent.
create_stationary(Location) :- 
    agent_create(stationary, Location, node_handler).

init(1) :-
assert(label('Number 1')),
consult('platform.pl'),
consult('stationary.pl'),
    %% Start the platform
    platform_start(localhost, 7001), %% Note: modify IP and port here if required
    set_token(9595),
    %% The `neighbour` predicate defines the edges from this node.
    assert(neighbour((localhost, 7002))),
    assert(neighbour((localhost, 7004))),
    %% The `visited` and `marked` predicates are initialized so that they can be used by agents which visit this node.
    %% Note: none is just a dummy predicate.
    assert(visited(none)),
    %% Create the stationary agent.
    get_platform_details(X,Y),
    create_stationary((X,Y)).

%% Remaining nodes are initilized similarly
init(2) :-
assert(label('Number 2')),
consult('platform.pl'),
consult('stationary.pl'),
    platform_start(localhost, 7002), %% Note: modify IP and port here if required
    set_token(9595),
    assert(neighbour((localhost, 7003))),
    assert(neighbour((localhost, 7001))),
    assert(visited(none)),
    %% Create the stationary agent.
    get_platform_details(X,Y),
    create_stationary((X,Y)).

init(3) :-
assert(label('Number 3')),
consult('platform.pl'),
consult('stationary.pl'),
    platform_start(localhost, 7003), %% Note: modify IP and port here if required
    set_token(9595),
    assert(neighbour((localhost, 7004))),
    assert(neighbour((localhost, 7002))),
    assert(neighbour((localhost, 7005))),
    assert(visited(none)),
    %% Create the stationary agent.
    get_platform_details(X,Y),
    create_stationary((X,Y)).

init(4) :-
assert(label('Number 4')),
consult('platform.pl'),
consult('stationary.pl'),
    platform_start(localhost, 7004), %% Note: modify IP and port here if required
    set_token(9595),
    assert(neighbour((localhost, 7001))),
    assert(neighbour((localhost, 7003))),
    assert(visited(none)),
    %% Create the stationary agent.
    get_platform_details(X,Y),
    create_stationary((X,Y)).

init(5) :-
assert(label('Number 5')),
consult('platform.pl'),
consult('stationary.pl'),
    platform_start(localhost, 7005), %% Note: modify IP and port here if required
    set_token(9595),
    assert(neighbour((localhost, 7003))),
    assert(visited(none)),
    %% Create the stationary agent.
    get_platform_details(X,Y),
    create_stationary((X,Y)).


%% Predicate to move the agent to it's next destination
go :-
    get_platform_details(X,Y),
    dfs_handler(explorer, (X, Y), execute).




