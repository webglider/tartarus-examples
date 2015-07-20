:- dynamic search_value/2.


%% Initialize the platform with given IP and Port.

init(IP,Port):-	
	[platform],			%% Consult the 'platform.pl' file.
	platform_start(IP,Port),	%% Run the platform.
	set_token(9595).		%% Set token in the platform for transaction.


%% Initialize the platform where 'X' stands for the number of the platform being initialized.

start(X):-
	atom_concat(p,X,P_id),		%% Extract the number of the platform from the P_id.
	consult('bst.pl'),		%% Consult the file containing handler.
	platform(P_id,IP,Port),		%% Extract (IP,PORT) With the specified P_id.
	init(IP,Port).			%% Initialize.

%% Create an agent on the root of the BST and execute it.

spawn_agent(X):-
	assert(search_value(guid,X)),	%% Assign the read value to a dynamic predicate.
	agent_create(scout,(localhost,4000),bst_handler),		%% Create the agent with name 'scout'.
	add_token(scout,[9595]),						%% Add token for authentication on all the platforms.
	add_payload(scout,[(search_value,2)]),				%% Add the value to be searched predicate
	agent_execute(scout,(localhost,4000),bst_handler).
