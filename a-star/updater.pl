%% Code for Updater Agent (UA)
%% Updates the `dist` and `came_from` predicates on target platform.
:-dynamic ua_handler/3.

ua_handler(guid, (_IP, _Port), main) :- 
    %% Fetch the data to be updated from the payload
    update_data(guid, Dist, Source),
    %% Update the data
    (current_predicate(dist/1) -> retract(dist(_)) ; true),
    (current_predicate(came_from/1) -> retract(came_from(_)) ; true),
    assert(dist(Dist)), assert(came_from(Source)),
    %% Suicide
    agent_kill(guid).
