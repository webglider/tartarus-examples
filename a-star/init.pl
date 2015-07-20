%% Initialization of platforms

getxy(N, Cols, X, Y) :- X is ceiling(N/Cols), Y is mod(N, Cols), Y>0.
getxy(N, Cols, X, Y) :- X is ceiling(N/Cols), Rem is mod(N,Cols), Rem=0, Y is Cols.

init(N) :- 
    consult('conf.pl'),
    path_to_tartarus(Path), consult(Path),
    base_port(Basep), Base is Basep - 1, Port is Base + N,
    platform_start(localhost, Port),
    set_token(9595),
    consult('updater.pl'),
    %% Get X,Y coords
    grid_size(Rows, Cols),
    getxy(N, Cols, X, Y),
    writeln(X), writeln(Y),
    %% manhattan distance
    ManDist is Rows-X+Cols-Y,
    assert(heuristic(ManDist)),
    %% Add neighbours
    %% north, east, west, south
    Up is X-1, Down is X+1,
    Left is Y-1, Right is Y+1,
    (Up > 0, Up =< Rows -> NPort is Base+(X-1-1)*Cols+Y, assert(neighbour((localhost, NPort), north)) ; true),
    (Down > 0, Down =< Rows -> SPort is Base+(X+1-1)*Cols+Y, assert(neighbour((localhost, SPort), south)) ; true),
    (Left > 0, Left =< Cols -> WPort is Base+(X-1)*Cols+Y-1, assert(neighbour((localhost, WPort), west)) ; true),
    (Right > 0, Right =< Cols -> EPort is Base+(X-1)*Cols+Y+1, assert(neighbour((localhost, EPort), east)) ; true),

    %% If jammed
    (jammed_node(X,Y) -> assert(jammed) ; true),

    %% If starting point initilize agent
    (N=1 -> 
    consult('explorer.pl'),
    agent_create(pea, (localhost, Port), pea_handler),
    add_token(pea, [9595]),
    %% Add payloads
    assert(priority(guid, (localhost, Port), ManDist)),
    assert(closed(guid, null)),
    add_payload(pea, [(priority, 3),(closed, 2)]),
    %% Set distance
    assert(dist(0)),
    %% start predicate
    assert((start :- agent_execute(pea, (localhost, Port), pea_handler)))

    ; true),

    %% If goal
    Ngoal is Rows*Cols,
    (N=Ngoal -> assert(is_goal),
                consult('tracer.pl'),
                agent_create(pta, (localhost, Port), pta_handler),
                add_token(pta, [9595]),
                add_payload(pta, [(reverse_dir,3), (path,2)]) 
        ; true).
