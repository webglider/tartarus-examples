:-dynamic refree_handler/3.

%% Handler for the refree mobile agent.


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

refree_handler(guid, (IP, Port), main) :- 
    %% Print present board state
    refree_handler(guid, (IP, Port), print_board),
    (current_predicate(home/0) -> Sym=x,Osym=o; Sym=o,Osym=x),

    %% Has somebody won?
    (refree_handler(guid, (IP, Port), has_won(Sym)) ->
        writeln('YOU HAVE WON THE GAME'),!,fail   
    ;true),
    (refree_handler(guid, (IP, Port), has_won(Osym)) ->
        writeln('YOU HAVE LOST THE GAME'),!,fail   
    ;true),


    writeln('Its your turn now!'),
    writeln('To make a move use mark(X,Y), example: mark(a,2).'),
    %% assert the mark predicate
    assert((mark(X,Y) :- refree_handler(guid, (IP, Port), make_move(X,Y)))).

refree_handler(guid, (IP, Port), make_move(X,Y)) :- 
    (current_predicate(home/0) -> Sym=x,Osym=o; Sym=o,Osym=x),
    %% Check if move is valid.
    (board(guid, X, Y, '_') ->
        
        %% Valid move
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
        retractall(mark(_,_)),
        agent_move(guid, (Destination_IP, Destination_Port))

    ;
        %% Invalid move
        writeln('Refree: Invalid move!')
    ).

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
