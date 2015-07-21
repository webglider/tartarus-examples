%% Predicates to handle the salesman agent.
:-dynamic salesman_handler/3.
:-dynamic checklist/2.

salesman_handler(guid, (_IP, _Port), main) :- 
    %% When the agent reaches a city
    %% Send log message
    name(Name), atom_concat('Reached ', Name, Msg),
    send_log(guid, Msg),

    %% If there are unvisited cities
    %% If all cities have been visited, prolog
    %% will backtrack to next clause definition
    %% Find the nearest unvisited neighbour
    findall(Price, (checklist(guid, City), price(City, Price)), L),
    min_list(L, Min),
    price(Destination, Min),
    %% Remove from checklist
    retract(checklist(guid, Name)),
    %% Move to Destination
    location(Destination, Location),
    agent_move(guid, Location),!.
    %% red cut used to ensure it does not backtrack
    
salesman_handler(guid, (_IP, _Port), main) :-
    %% If no such unvisited city exists
    %% The journey is complete
    writeln('Journey complete'),
    send_log(guid, 'Journey complete').

%% Checklist for salesman
checklist(guid, paris).
checklist(guid, nice).
checklist(guid, grenoble).
checklist(guid, lyon).
checklist(guid, marseille).


%% Predicate to create and initialize agent.
start :- 
    get_platform_details(IP, Port),
    %% Create agent
    agent_create(salesman, (IP, Port), salesman_handler),
    add_token(salesman, [9595]),
    %% add checklist payload
    add_payload(salesman, [(checklist, 2)]),
    %% Execute agent
    agent_execute(salesman, (IP, Port), salesman_handler).


    
