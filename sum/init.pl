%% These predicates are meant to be used to initialize the platforms for this example


%% Starting point
init :- 
    consult('platform.pl'),
    consult('adder.pl'),
    platform_start(localhost, 3434),
    set_token(9595),
    agent_create(myadder, (localhost, 3434), sum_handler),
    add_token(myadder, [9595]),
    %% The `result` predicate is added as payload to the agent
    assert(result(guid, 0)),
    add_payload(myadder, [(result, 2)]),
    writeln('Initialization complete').

start :-
    agent_execute(myadder, (localhost, 3434), sum_handler).

%% platform 1
init1 :- 
    consult('platform.pl'),
    platform_start(localhost, 7001),
    set_token(9595),
    assert(value(3)),
    assert(next_port(7002)),
    writeln('initialization complete').

%% platform 2
init2 :- 
    consult('platform.pl'),
    platform_start(localhost, 7002),
    set_token(9595),
    assert(value(4)),
    assert(next_port(7003)),
    writeln('initialization complete').

%% platform 3
init3 :- 
    consult('platform.pl'),
    platform_start(localhost, 7003),
    set_token(9595),
    assert(value(5)),
    assert(next_port(3434)),
    writeln('initialization complete').