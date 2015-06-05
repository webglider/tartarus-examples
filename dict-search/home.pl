%% predicates to initialize the home platform.

:-dynamic list/2.

location(localhost, 3434).

%% List of dictionaries to search through
list(guid, (localhost, 7001)).

%% Use this predicate to initialize the home platform
init :- 
    consult('conf.pl'),
    path_to_tartarus(Path),
    consult(Path),
    location(IP ,Port), platform_start(IP, Port),
    set_token(9595),
    %% Create agent
    agent_create(search, (IP, Port), search_handler),
    add_token(search, [9595]),
    add_payload(search, [(list, 2)]).

%% Use this predicate to start the search.
search :- 
    writlen('Enter a word to search:'),
    read(Word),
    assert(target(guid, Word)), add_payload(search, [(target, 2)]),
    assert(meaning(guid, null)), add_payload(search, [(meaning, 2)]),
    %% execute agent
    get_platform_details(X,Y),
    agent_execute(search, (X,Y), search_handler).