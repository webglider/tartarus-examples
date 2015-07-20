:- dynamic bst_handler/3.
:- dynamic search_value/2.


%% Dynamically define platform ids with respect to ports
%% Useful while running several platforms on a single machine

platforms(P_id,IP,Port):- 
	atom_concat(p,X,P_id),
	(P_id = p1 , IP = localhost , Port = X).


%% Assigning platform ids using platform predicate.
%% ** TO BE DONE BEFORE EXECUTION **


platform(P_id,IP,Port):-

	(P_id = p1 , IP = localhost , Port = 4000);
	(P_id = p2 , IP = localhost , Port = 4001);
	(P_id = p3 , IP = localhost , Port = 4002);
	(P_id = p4 , IP = localhost , Port = 4003);
	(P_id = p5 , IP = localhost , Port = 4004);
	(P_id = p6 , IP = localhost , Port = 4005);
	(P_id = p7 , IP = localhost , Port = 4006);
	(P_id = p8 , IP = localhost , Port = 4007).



%% Based on the input graph neighbors of each platform are specified.
%% This can be done using a script for large graphs.
%% ** TO BE DONE BEFORE EXECUTION **

children(P,L,R):-
	
	(P=p1,L=p2,R=p3);
	(P=p2,L=p4,R=p5);
	(P=p3,L=p6,R=p7);
	(P=p6,L=none,R=p8).


%% Assigning values to each platform.
%% ** TO BE DONE BEFORE EXECUTION **

value_at(P_id,X):-
	
	(P_id = p1 , X =10);
	(P_id = p2 , X =5);
	(P_id = p3 , X =15);
	(P_id = p4 , X =3);
	(P_id = p5 , X =8);
	(P_id = p6 , X =13);
	(P_id = p7 , X =17);
	(P_id = p8 , X =14).




%% Handler for bst agent.

bst_handler(guid,(IP,Port),main):-
	writeln('bst agent executing on port ' : Port),
	sleep(1),						%% Delay for one second
	platform(P_id,IP,Port),					%% Extract platform IP and Port from P_id
	value_at(P_id,Xp),					%% Extract value Xp at P_id
	search_value(guid,X),					%% Extract search_value X from the payload
	write('search value ': X),writeln('value at ' : Xp),
	Xp = X,							%% Only true if the value at the platform and search value are equal
	writeln('equal'),
	writeln('done').


bst_handler(guid,(IP,Port),main):-
	writeln('bst agent executing on port ' : Port),
	sleep(3),						%% Delay for one second
	platform(P_id,IP,Port),					%% Extract platform IP and Port from P_id
	value_at(P_id,Xp),					%% Extract value Xp at P_id
	search_value(guid,X),					%% Extract search_value X from the payload
	write('search value ': X),writeln('value at ' : Xp),
	\+(Xp = X),						%% True when search value and value on the platform are not equal
	writeln('not equal'),
	children(P_id,L,R),					%% Extract Left child L and Right child R of P_id
	%% If value of platform is greater than search value,get NewIP and NewPort of left child else get from right child 
	(Xp > X -> platform(L,NewIP,NewPort)  ;  platform(R,NewIP,NewPort) ),
	writeln('moving to port ': NewPort),
	agent_move(guid,(NewIP,NewPort)),			%% Move agent to the NewIP and NewPort
	writeln('done').

