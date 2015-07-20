%% Predicates to handle the mobile agents
:-dynamic sort_handler/3.

%% The agent holds `state` predicate which represents it's 
%% present state. In this example the agent can be in 3 states
%% 1. moving_left
%% 2. done
%% 3. nothing

%% Main handler
%% Choose what action to do depending on present state
%% If in state moving_left
sort_handler(guid, (IP, Port), main) :- state(guid, moving_left),
    sort_handler(guid, (IP, Port), move_left).

%% If in state done
sort_handler(guid, (IP, Port), main) :- state(guid, done),
    sort_handler(guid, (IP, Port), finish).

%% If in state nothing
sort_handler(guid, (_IP, _Port), main) :- state(guid, nothing),
    %% Do nothing
    true.
%% ------------------------------------------------------------------
%% Move left handler

%% If a smaller number is reached, 
%% agent needs to move back right
sort_handler(guid, (IP, Port), move_left) :- 
    agent_isexist(Agent, (IP, Port), sort_handler), 
    value(Agent, Val), value(guid, Myval), Val < Myval,
    %% Move right and finish
    %% Set state to done
    retract(state(guid, moving_left)), assert(state(guid, done)),
    right(Destination), agent_move(guid, Destination), !.


%% If smaller number is not reached, the agent must try to move left

%% There are 2 cases:
%% If at left most end
sort_handler(guid, (IP, Port), move_left) :- left(null),
    sort_handler(guid, (IP,Port), send_others_right),
    retract(state(guid, _)), assert(state(guid, done)),
    sort_handler(guid, (IP, Port), finish), !.


%% If not at left most end
sort_handler(guid, (IP, Port), move_left) :- not(left(null)),
    sort_handler(guid, (IP,Port), send_others_right),
    %% Ensure state is moving_left
    retract(state(guid, _)), assert(state(guid, moving_left)),
    %% Move left
    left(Destination),
    agent_move(guid, Destination). 

%% -------------------------------------------------------------------
%% This predicate will send any other agents
%% present on the platform to the right
sort_handler(guid, (IP, Port), send_others_right) :- 
      %% If another agent exists tell it to move right
    (agent_isexist(Agent, (_,_), sort_handler),Agent\=guid -> 
        agent_execute(Agent, (IP, Port), sort_handler, move_right)
    ;
        true
    ).
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
    retract(state(guid, _)), assert(state(guid, nothing)).