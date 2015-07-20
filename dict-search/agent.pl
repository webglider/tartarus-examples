%% Predicates for search agent.
:-dynamic search_handler/3.

%% Main handler

%% ------------- Agent at home platform ------------------------------------


%% If agent is at home (starting point) and is yet to search
search_handler(guid, (IP, Port), main) :- 
    home(guid, (IP, Port)), meaning(guid, null), 
    list(guid, Location), agent_move(guid, Location), !.

%% If agent has returned home after search
search_handler(guid, (IP, Port), main) :- 
    home(guid, (IP, Port)), meaning(guid, Meaning),
    Meaning \= null,
    %% Print the found meaning
    writeln(Meaning),
    %% Kill the agent
    agent_kill(guid), !.


%% ------------------------------------------------------------------------

%% -------------- Agent at a dictionary platform --------------------------

%% If target word is in platform's dictionary.
search_handler(guid, (IP, Port), main) :- not(home(guid, (IP, Port))), 
    target(guid, Target), word(Target, Meaning),

    %% Store meaning as payload
    retract(meaning(guid, _)), assert(meaning(guid, Meaning)),
    %% Move agent back home
    home(guid, Home), agent_move(guid, Home), !.

%% If the target word is not found
search_handler(guid, (IP, Port), main) :- not(home(guid, (IP, Port))),
    target(guid, Target), not(word(Target, _)),

    %% Remove present location from list
    retract(list(guid, (IP,Port))),
    %% Move to next location
    list(guid, Location), agent_move(guid, Location), !.

%% If no more locations left
search_handler(guid, (IP, Port), main) :- not(home(guid, (IP, Port))),
    target(guid, Target), not(word(Target, _)),
    not(list(guid, _)),

    %% word not found anywhere
    retract(meaning(guid, _)), assert(meaning(guid, 'Word not found!')),
    %% Move agent back home 
    home(guid, Home), agent_move(guid, Home).
%% ----------------------------------------------------------------------