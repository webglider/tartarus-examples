%% Predicates to handle the mobile agents
:-dynamic sort_handler/3.

%% Main handler
%% If in state moving_left
sort_handler(guid, (IP, Port), main) :- state(guid, moving_left),
    sort_handler(guid, (IP, Port), move_left).

%% If in state done
sort_handler(guid, (IP, Port), main) :- state(done),
    sort_handler(guid, (IP, Port), finish).

%% If in state nothing
sort_handler(guid, (_IP, _Port), main) :- state(nothing),
    %% Do nothing
    true.
%% ------------------------------------------------------------------
%% Move left handler
%% If at left most end
sort_handler(guid, (IP, Port), move_left) :- left(null),
    sort_handler(guid, (IP, Port), finish), !.

%% If a smaller number is reached
sort_handler(guid, (IP, Port), move_left) :- 
    agent_isexist(Agent, (IP, Port), sort_handler), 
    value(Agent, Val), value(guid, Myval), Val < Myval,
    %% Move right and finish
    %% Set state to done
    retract(state(guid, moving_left)), assert(state(guid, done)),
    right(Destination), agent_move(guid, Destination), !.

%% Otherwise move left
sort_handler(guid, (IP, Port), move_left) :- 
    %% If another agent exists tell it to move right
    (agent_isexist(Agent, (_,_), sort_handler),Agent\=guid -> 
        agent_execute(Agent, (IP, Port), sort_handler, move_right)
    ;
        true
    ),
    %% Ensure state is moving_left
    retract(state(guid, _)), assert(state(guid, moving_left)),

    %% Move left
    left(Destination),
    agent_move(guid, Destination). 

%% -------------------------------------------------------------------

%% Move right handler
sort_handler(guid, (_IP, _Port), move_right) :- 
    writeln('Moving right'),
    right(Destination),
    agent_move(guid, Destination).

%% Finish handler
sort_handler(guid, (_IP, _Port), finish) :- 
    value(guid, Val),
    writeln('***-----Value inserted here':Val),
    retract(state(guid, done)), assert(state(guid, nothing)).