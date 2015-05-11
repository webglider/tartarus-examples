%% This file contains predicates to start the agent
%% The `start` predicate can be called from any one of the initialized nodes in the network

init :- 
    consult('explorer.pl'),
    get_platform_details(X,Y),
    %% Create agent on the platform
    agent_create(explorer, (X, Y), dfs_handler),
    writeln('agent has been created'),  
    %% Token is added to authenticate the agent on all platforms in the network
    add_token(explorer, [9595]),
    %% payload predicate `just_before` is added to agent.
    assert(just_before(guid, none)),
    add_payload(explorer, [(just_before,2)]),
    writeln('Agent is ready to roll!').
    
start :- 
    %% agent is now executed
    agent_execute(explorer, (X,Y), dfs_handler).