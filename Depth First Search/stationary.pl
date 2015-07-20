%% This file conatins all the predicates to handle startionary agents on all the platforms.

:-dynamic node_handler/3.

%% Stationary agents respond to requests sent by the `explorer` mobile agent.
%% If the corresponding node has not yet been visited by `explorer` the agent gives a good response
%% Otherwise it gives a bad response.
node_handler(guid, (S_IP, S_Port), get_status(Agent)) :- 
    %% Get platform IP and port
    get_platform_details(IP,Port),
    (visited(Agent) ->
        
        %% send bad response
        writeln('sending bad repsonse'),
        agent_post(platform, (S_IP, S_Port), [dfs_handler, explorer, (IP,Port), response_bad])
    ;
        %% send good response
        writeln('sending good response'),
        agent_post(platform, (S_IP, S_Port), [dfs_handler, explorer, (IP,Port), response_good])
    ).