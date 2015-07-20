:-dynamic sum_handler/3.


%% Main handler for the mobile agent

sum_handler(guid, (IP,Port), main) :-
    %% If not at starting point then pick up value and continue
    %% The value is stored in the `value` predicate on each platform
    %% The next port to move to is stored in the `next_port` predicate of each platform
    Port\=3434, 
    writeln('agent about to pick up value'),
    value(X),
    retract(result(guid, Y)),
    Z is X+Y,
    assert(result(guid, Z)),
    next_port(NPort),
    agent_move(guid, (localhost, NPort)).

sum_handler(guid, (IP,Port), main) :-
    Port = 3434,
    current_predicate(started/0), 
    %% This means the agent has returned after collecting all the values
    writeln('process ended'),
    writeln('result is'),
    result(guid, X),
    writeln(X).


sum_handler(guid, (IP,Port), main) :-
    Port = 3434,
    \+current_predicate(started/0),
    %% This is when the agent just starts from the starting point (port 3434)
    writeln('process started'),
    assert(started),
    agent_move(guid, (localhost, 7001)).