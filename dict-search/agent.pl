%% Predicates for search agent.
:-dynamic search_handler/3.

%% Main handler
search(guid, (IP, Port), main) :- 
    %% If target word is in platform's dictionary.
    target(guid, Target), word(Target, Meaning),
    %% Store meaning as payload
    retract(meaning(guid, _)), assert(meaning(guid, Meaning)),
    %% Move agent back home
    home(guid, Home), agent_move(guid, home), !.

%% If the target word is not found
search(guid, (IP, Port), main) :- 
    %% Remove present location from list
    retract(list(guid, (IP,Port))),
    %% Move to next location
    list(guid, Location), agent_move(guid, Location), !.

%% If no more locations left
search(guid, (IP, Port), main) :- 
    %% word not found
    retract(meaning(guid, _)), assert(meaning(guid, 'Word not found!')),
    %% Move agent back home
    home(guid, Home), agent_move(guid, home).
