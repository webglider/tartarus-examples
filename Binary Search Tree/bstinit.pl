:- dynamic search_value/2.


%% Create an agent on the root of the BST and execute it.

spawn_agent(X):-
	get_platform_details(IP,Port),
	assert(search_value(guid,X)),	%% Assign the read value to a dynamic predicate.
	agent_create(scout,(localhost,Port),bst_handler),		%% Create the agent with name 'scout'.
	add_token(scout,[9595]),						%% Add token for authentication on all the platforms.
	add_payload(scout,[(search_value,2)]),				%% Add the value to be searched predicate
	agent_execute(scout,(localhost,Port),bst_handler).


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
	init(IP,Port),			%% Initialize.
	init(P_id).


%% Based on the input graph neighbors of each platform are specified.
%% This can be done using a script for large graphs.
%% ** TO BE DONE BEFORE EXECUTION **

init(p1):- 	assert(children(p1,p2,p3)),assert(value_at(p1,10)).
init(p2):- 	assert(children(p2,p4,p5)),assert(value_at(p2,5)).
init(p3):- 	assert(children(p3,p6,p7)),assert(value_at(p3,15)).
init(p4):- 	assert(children(p4,none,none)),assert(value_at(p4,3)).
init(p5):- 	assert(children(p5,none,none)),assert(value_at(p5,8)).
init(p6):- 	assert(children(p6,none,p8)),assert(value_at(p6,13)).
init(p7):- 	assert(children(p7,none,none)),assert(value_at(p7,17)).
init(p8):- 	assert(children(p8,none,none)),assert(value_at(p8,14)).

%% Assigning values to each platform.
%% ** TO BE DONE BEFORE EXECUTION **

%value_at(P_id,X):-
%	
%	(P_id = p1 , X =10);
%	(P_id = p2 , X =5);
%	(P_id = p3 , X =15);
%	(P_id = p4 , X =3);
%	(P_id = p5 , X =8);
%	(P_id = p6 , X =13);
%	(P_id = p7 , X =17);
%	(P_id = p8 , X =14).

%% Assigning platform ids using platform predicate.
%% ** TO BE DONE BEFORE EXECUTION **

%% For instantiating Port from P_id.
platform(P_id,localhost,Port):-
	atom(P_id),						%% Check if P_id is instantiated.
	atom_concat(p,X,P_id),			%% Extract platform number.
	atom_concat(500,X,Y),			%% Get port number using platform number.
	atom_number(Y,Port),!.			%% Convert port into number.
%% For instanciating P_id from Port.
platform(P_id,localhost,Port):-
	atom_concat(500,X,Port),		%% Extract platform number from Port.
	atom_concat(p,X,P_id).			%% Get platform id using platform number.

%% Use the below format to explicitly assign platforms.
%platform(P_id,IP,Port):-
%	(P_id = p1 , IP = localhost , Port = 4000);
%	(P_id = p2 , IP = localhost , Port = 4001);
%	(P_id = p3 , IP = localhost , Port = 4002);
%	(P_id = p4 , IP = localhost , Port = 4003);
%	(P_id = p5 , IP = localhost , Port = 4004);
%	(P_id = p6 , IP = localhost , Port = 4005);
%	(P_id = p7 , IP = localhost , Port = 4006);
%	(P_id = p8 , IP = localhost , Port = 4007).


