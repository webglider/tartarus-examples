%% Setup script

setup :- 
    consult('conf.pl'),
    grid_size(X,Y),
    Total is X*Y,
    chain_create(Total).

chain_create(0).
chain_create(N) :- N>0,
    swipl_command(Comm),
    atomic_list_concat(Broken, '<command>', Comm),
    atom_concat('init(',N,A), atom_concat(A,')',B),
    atomic_list_concat(Broken, B, Final),
    writeln(Final),
    shell(Final),
    M is N-1,
    chain_create(M).