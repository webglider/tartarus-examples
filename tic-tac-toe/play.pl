:-dynamic board/4.


%% Board payload
board(guid, a, 1, '_').
board(guid, a, 2, '_').
board(guid, a, 3, '_').
board(guid, b, 1, '_').
board(guid, b, 2, '_').
board(guid, b, 3, '_').
board(guid, c, 1, '_').
board(guid, c, 2, '_').
board(guid, c, 3, '_').


%% Start the game
%% Refree agent is initialized
start :-
    get_platform_details(IP, Port), 
    agent_create(refree, (IP, Port), refree_handler),
    add_token(refree, [9595]),
    %% Add the board payload
    add_payload(refree, [(board, 4)]),
    assert(home),
    writeln('Remember to set play_with!'),

    agent_execute(refree, (IP, Port), refree_handler).