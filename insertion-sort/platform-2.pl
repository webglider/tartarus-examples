%% Predicates for platform initialization

%% --------------------------Configuartion-------------------------

%% Location of platform
location(localhost, 7002).

%% Left and right platforms
left((localhost, 7001)).
right((localhost, 7003)).

%% Initial value on this platform
initial_value(74).

%% ----------------------------------------------------------------

%% Call this predicate to initialize
init :- 
    consult('conf.pl'),
    path_to_tartarus(Path), consult(Path),

    %% Start platform
    location(IP, Port), platform_start(IP, Port),
    set_token(9595),

    %% Create agent on this platform
    consult('agent.pl'),
    agent_create(Name, (IP, Port), sort_handler),
    add_token(Name, [9595]),

    %% Add payloads to agent
    initial_value(Val),
    assert(value(guid, Val)),
    assert(state(guid, nothing)),
    add_payload(Name, [(value, 2), (state, 2)]),

    writeln('------------------- PLATFORM 2 -----------------------').

%% Use this predicate to insert agent on this platform at correct location
insert :- 
    %% Get agent's name
    agent_isexist(Name, _, sort_handler),
    get_platform_details(IP, Port),
    %% Start the insertion process
    agent_execute(Name, (IP, Port), sort_handler, move_left).

    %% Use this predicate to view final value after sorting
final_value(Val) :- 
    agent_isexist(Agent, _, sort_handler),
    value(Agent, Val).

