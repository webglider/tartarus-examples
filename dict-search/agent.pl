%% Predicates for search agent.
:-dynamic search_handler/3.

%% Main handler

%% ------------- Agent at home platform ------------------------------------

%% If agent has returned home after search
search_handler(guid, (IP, Port), main) :- 
    home(guid, (IP, Port)), meaning(guid, Meaning),
    Meaning \= null,
    %% Print the found meaning
    writeln(Meaning),
    %% Kill the agent
    agent_kill(guid), !.

%% If agent is at home starting point
search_handler(guid, (IP, Port), main) :- 
    home(guid, (IP, Port)),
    list(guid, Location), agent_move(guid, Location), !.

%% ------------------------------------------------------------------------

%% -------------- Agent at a dictionary platform --------------------------

%% If target word is in platform's dictionary.
search_handler(guid, (_IP, _Port), main) :- 
    target(guid, Target), word(Target, Meaning),
    %% Store meaning as payload
    retract(meaning(guid, _)), assert(meaning(guid, Meaning)),
    %% Move agent back home
    home(guid, Home), agent_move(guid, Home), !.

%% If the target word is not found
search_handler(guid, (IP, Port), main) :- 
    %% Remove present location from list
    retract(list(guid, (IP,Port))),
    %% Move to next location
    list(guid, Location), agent_move(guid, Location), !.

%% If no more locations left
search_handler(guid, (_IP, _Port), main) :- 
    %% word not found
    retract(meaning(guid, _)), assert(meaning(guid, 'Word not found!')),
    %% Move agent back home 
    home(guid, Home), agent_move(guid, Home).
%% ----------------------------------------------------------------------