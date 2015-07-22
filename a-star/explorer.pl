%% Code for the Path Exploring Agent (PEA)
%% Uses the A* search algorithm to explore the grid
:-dynamic pea_handler/3.

%% If goal has been reached
pea_handler(guid, (IP, Port), main) :- current_predicate(is_goal/0),
    writeln('Reached Goal!'), agent_execute(pta, (IP, Port), pta_handler).

% If goal has not been reached
pea_handler(guid, (IP, Port), main) :- not(current_predicate(is_goal/0)),
    %% If the node is jammed do nothing
    (current_predicate(jammed/0) -> true ;
    % Otherwise
        %% Make a list of neighbours
        findall((N,Dir), (neighbour(N,Dir), N\=null), L),
        %% Handle neighbours in the list
        pea_handler(guid, (IP,Port), handle_neighbours(L))
    ),

    %% Remove node from fringe and add to closed.
    retract(priority(guid, (IP, Port), _)),
    assert(closed(guid, (IP,Port))),
    %% Move to least priority
    findall(Val, priority(guid, _, Val), PriList),
    min_list(PriList, Min),
    priority(guid, Next, Min),
    agent_move(guid, Next).
    

%% Pedicate to handle neighbours
%% Empty list (base case)
pea_handler(guid, (_IP,_Port), handle_neighbours([])).
%% Recursively handle neighbours if non empty list

% If top of list is already in closed then continue to next
pea_handler(guid, (IP, Port), handle_neighbours([(N,_)|T])) :- closed(guid, N),
    pea_handler(guid, (IP, Port), handle_neighbours(T)).
    
% If top of list is not in closed set, then process it
pea_handler(guid, (IP, Port), handle_neighbours([(N,Dir)|T])) :- not(closed(guid, N)),
     %% find new priority value
    dist(G),heuristic(H),
    ((Dir=north;Dir=east) -> NewVal is G+1+H-1; NewVal is G+1+H+1),
    (priority(guid, N, OldVal) ->
        %% Already in the fringe
        (NewVal<OldVal ->
            retract(priority(guid, N, OldVal)), assert(priority(guid, N, NewVal)),
            %% Update the neighbour
            NewDist is G+1,
            pea_handler(guid, (IP, Port), update(N, NewDist))
            ;
            %% Do nothing
            true 
            )
         ;
            %% Not in fringe
            %% add to priority queue
            assert(priority(guid, N, NewVal)),
            Dist is G+1,
            pea_handler(guid, (IP, Port), update(N, Dist))

        ),
    pea_handler(guid, (IP, Port), handle_neighbours(T)).

%% Predicate to update neighbours
%% Spawns update agent to update the given node
pea_handler(guid, (IP, Port), update(V, Dist)) :- 
    %% Spawn update agent
    agent_create(Name, (IP,Port), ua_handler),
    add_token(Name, [9595]),
    %% Add distance data and source as payload
    assert(update_data(Name, Dist, (IP, Port))),
    add_payload(Name, [(update_data,3)]),
    %% Move agent to update target
    agent_move(Name, V).

