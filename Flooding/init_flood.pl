
%% Initialization of root platform.
init :-
	consult('platform.pl'),
	consult('flood.pl'),
	platform_start(localhost,6000),							%% Start platform
	set_token(9595),										%% initialization of token 
	assert_neighbors(p0),									%% initialization of neighbors of the current platform

	%% Agent creation and initialization
	agent_create(ant,(localhost,6000),spawn_agent_handler),	%% Creating an agent.
	add_token(ant,[9595]),									%% Adding token to the agent.
	assert(layer_number(guid,0)),							%% Layer numeber as payload.
	add_payload(ant,[(layer_number,2)]).					%% add payload to the agent.

start:-
	agent_execute(ant,(localhost,6000),spawn_agent_handler).	%% Execute the agent to start the flooding.

%% Initialization on platform other than root.
init(X):-
	consult('platform.pl'),	
	consult('flood.pl'),			
	atom_concat(600,X,P),								%% Extract platform number from port.
	atom_number(P,N),									%% Convert port from atom to number.
	platform_start(localhost,N),						%% Start platform.
	set_token(9595),									%% initialization of token.
	atom_concat(p,X,P_id),								%% Get platform id from the platform number.
	assert_neighbors(P_id).								%% initialization of neighbors of the current platform.


%% Based on the input graph neighbors of each platform are specified.
%% This can be done using a script for large graphs.
%% ** TO BE DONE BEFORE EXECUTION **

%% Example 1
/*
assert_neighbors(p0):-	assert(neighbors(p0,[p1,p2])).
assert_neighbors(p1):-	assert(neighbors(p1,[p0,p3,p4])).
assert_neighbors(p2):-	assert(neighbors(p2,[p0,p4])).
assert_neighbors(p3):-	assert(neighbors(p3,[p1])).
assert_neighbors(p4):-	assert(neighbors(p4,[p1,p2])).
*/

%% Example 2
assert_neighbors(p0):-	assert(neighbors(p0,[p1,p2])).
assert_neighbors(p1):-	assert(neighbors(p1,[p3,p4])).
assert_neighbors(p2):-	assert(neighbors(p2,[p5,p6])).
assert_neighbors(p3):-	assert(neighbors(p3,[p1])).
assert_neighbors(p4):-	assert(neighbors(p4,[p1])).
assert_neighbors(p5):-	assert(neighbors(p5,[p2])).
assert_neighbors(p6):-	assert(neighbors(p6,[p2])).




%% Assigning platform ids using platform predicate.
%% ** TO BE DONE BEFORE EXECUTION **
%% Use this format to explicitly assign port number to platform ids.

%	(P_id = p0 , IP = localhost , Port = 5000);
%	(P_id = p1 , IP = localhost , Port = 5001);
%	(P_id = p2 , IP = localhost , Port = 5002);
%	(P_id = p3 , IP = localhost , Port = 5003);
%	(P_id = p4 , IP = localhost , Port = 5004);
%	(P_id = p5 , IP = localhost , Port = 5005).

%% For instantiating Port from P_id.
platform(P_id,localhost,Port):-
	atom(P_id),						%% Check if P_id is instantiated.
	atom_concat(p,X,P_id),			%% Extract platform number.
	atom_concat(600,X,Y),			%% Get port number using platform number.
	atom_number(Y,Port).			%% Convert port into number.
%% For instanciating P_id from Port.
platform(P_id,localhost,Port):-
	atom_concat(600,X,Port),		%% Extract platform number from Port.
	atom_concat(p,X,P_id).			%% Get platform id using platform number.

