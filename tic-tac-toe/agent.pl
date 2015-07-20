:-dynamic refree_handler/3.

%% Handler for the refree mobile agent.

%% The agent carries the `board` predicate as payload
%% board(guid, Row, Col, Symbol)
%% Row -> row in grid (a or b or c)
%% Col -> column in grid (1 or 2 or 3)
%% Symbol -> symbol presently in position (Row,Col)
%% Symbol can be `x` or `o` or `_`

%% Prints a single row of the board on a line
refree_handler(guid, _, print_row(R)) :-
    nl, write(R),
    board(guid,R,1,X),write(' '),write(X),
    board(guid,R,2,Y),write('  '),write(Y),
    board(guid,R,3,Z),write('  '),write(Z),nl.

%% Prints the present state of the game board
refree_handler(guid, _, print_board) :- 
    writeln('----------'),
    writeln('  1  2  3'),
    refree_handler(guid, nothing, print_row(a)),
    refree_handler(guid, nothing, print_row(b)),
    refree_handler(guid, nothing, print_row(c)),
    writeln('----------').

%% Predicate to find symbol of present player
%% refree_handler(guid, _, symbols(This, Other))
%% `This` is unfied with symbol of player on present platform
%% `Other` is unified with symbol of player on other platform
refree_handler(guid, _, symbols(x,o)) :- current_predicate(home/0).
refree_handler(guid, _, symbols(o,x)) :- not(current_predicate(home/0)).


%% Main Handler
%% This is executed as soon as the agent reaches a platform
refree_handler(guid, (IP, Port), main) :- 
    %% Print present board state
    refree_handler(guid, (IP, Port), print_board),
    refree_handler(guid, nothing, symbols(Sym, Osym)),

    %% Has somebody won?
    %% fail ensures that execution does not continue if the game has terminated
    (refree_handler(guid, (IP, Port), has_won(Sym)) ->
        writeln('YOU HAVE WON THE GAME'),!,fail   
    ;true),
    (refree_handler(guid, (IP, Port), has_won(Osym)) ->
        writeln('YOU HAVE LOST THE GAME'),!,fail   
    ;true),

    %% Take input from player
    refree_handler(guid, (IP,Port), take_input).


%% This predicate takes input of the move the player wants to make
refree_handler(guid, (IP,Port), take_input) :- 
    writeln('Its your turn now!'),
    writeln('Enter row [a or b or c]: '), read(Row),
    writeln('Enter column [1 or 2 or 3]: '), read(Col),
    %% try to make move
    refree_handler(guid, (IP, Port), make_move(Row,Col)).

%% This predicate tries to make the move which the user has input
%% If the move is not valid as for input again
refree_handler(guid, (IP, Port), make_move(X,Y)) :- not(board(guid, X, Y, '_')),
        writeln('Refree: Invalid move!'),
        refree_handler(guid, (IP,Port), take_input).

%% If the move is valid
refree_handler(guid, (IP, Port), make_move(X,Y)) :- board(guid, X, Y, '_'),
    refree_handler(guid, (IP, Port), symbols(Sym, Osym)),
    write('Refree: You made a move at location '), 
    write(X),write(','),write(Y),nl,
    retract(board(guid, X,Y, '_')),
    assert(board(guid,X,Y,Sym)),
    refree_handler(guid, (IP, Port), print_board),

    %% Has somebody won?
    (refree_handler(guid, (IP, Port), has_won(Sym)) ->
        writeln('YOU HAVE WON THE GAME')   
    ;true),
    (refree_handler(guid, (IP, Port), has_won(Osym)) ->
        writeln('YOU HAVE LOST THE GAME')   
    ;true),

    %% Move the agent.
    play_with(Destination_IP, Destination_Port),
    agent_move(guid, (Destination_IP, Destination_Port)).

%% Tic tac toe logic
refree_handler(guid, _, has_won(S)) :- 
    %% Horizontal?
    board(guid, Row, One, S), board(guid, Row, Two, S), 
    board(guid, Row, Three, S), One \= Two, Two \= Three, One \= Three.
refree_handler(guid, _, has_won(S)) :- 
    %% Vertical?
    board(guid, One, Col, S), board(guid, Two, Col, S), 
    board(guid, Three, Col, S), One \= Two, Two \= Three, One \= Three.
refree_handler(guid, _, has_won(S)) :-
    %% Main Diagonal?
    board(guid, b, 2, S), board(guid, a, 1, S), board(guid, c, 3, S).
refree_handler(guid, _, has_won(S)) :-
    %% Off Diagonal?
    board(guid, b, 2, S), board(guid, c, 1, S), board(guid, a, 3, S).
