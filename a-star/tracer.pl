%% Code for path tracing agent (PTA).
:- dynamic pta_handler/3.
:- dynamic reverse_dir/3.
:- dynamic path/2.

%% If not yet at home
%% `came_predicate` is defined
pta_handler(guid, (_IP, _Port), main) :- current_predicate(came_from/1),
    
        came_from(Next),
        neighbour(Next, Dir),
        %%Reverse the direction
        reverse_dir(guid, Dir, Move),
        %% Add move to payload list.
        retract(path(guid, Path)),
        assert(path(guid, [Move|Path])),
        %% Move to next node
        agent_move(guid, Next), !.



    %% If reached home
        %% Print path
pta_handler(guid, (_IP, _Port), main) :- not(current_predicate(came_from/1)),   
        path(guid, Path),
        writeln('Shortest path to goal: '),
        writeln(Path).

%% Payload predicate to reverse direction
reverse_dir(guid, north, south).
reverse_dir(guid, south, north).
reverse_dir(guid, east, west).
reverse_dir(guid, west, east).

%% Payload to store path
path(guid, []).