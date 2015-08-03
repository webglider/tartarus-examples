:- dynamic bst_handler/3.
:- dynamic search_value/2.


%% Handler for bst agent.

%% Handler if the search_value and value on the platform are equal
bst_handler(guid,(IP,Port),main):-
	attach_console,
	writeln('bst agent executing on port ' : Port),
	sleep(1),						%% Delay for one second
	platform(P_id,IP,Port),					%% Extract platform IP and Port from P_id
	value_at(P_id,Xp),					%% Extract value Xp at P_id
	search_value(guid,X),					%% Extract search_value X from the payload
	write('search value ': X),writeln('value at ' : Xp),
	Xp = X,							%% Only true if the value at the platform and search value are equal
	writeln('equal'),
	writeln('done').

%% Handler if the value on the platform is greater than the search_value
bst_handler(guid,(IP,Port),main):-
	attach_console,
	writeln('bst agent executing on port ' : Port),
	sleep(3),						%% Delay for three seconds
	platform(P_id,IP,Port),					%% Extract platform IP and Port from P_id
	value_at(P_id,Xp),					%% Extract value Xp at P_id
	search_value(guid,X),					%% Extract search_value X from the payload
	write('search value ': X),writeln('value at ' : Xp),
	Xp > X,						%% True when search value is less than the value on the platform
	writeln('not equal'),
	children(P_id,L,R),					%% Extract Left child L and Right child R of P_id
	bst_handler(guid,(IP,Port),move_to(L)).	%% Move to the Left

%% Handler if the value on the platform is less that the search_value
bst_handler(guid,(IP,Port),main):-
	attach_console,
	writeln('bst agent executing on port ' : Port),
	sleep(3),						%% Delay for three seconds
	platform(P_id,IP,Port),					%% Extract platform IP and Port from P_id
	value_at(P_id,Xp),					%% Extract value Xp at P_id
	search_value(guid,X),					%% Extract search_value X from the payload
	write('search value ': X),writeln('value at ' : Xp),
	Xp < X,						%% True when search value is greater than the value on the platform
	writeln('not equal'),
	children(P_id,L,R),					%% Extract Left child L and Right child R of P_id
	bst_handler(guid,(IP,Port),move_to(R)).	%% Move to the right platform


%% Move to the right or left platform only if P is not equal to none
bst_handler(guid,(IP,Port),move_to(P)):-
	attach_console,
	P = none,											%% If P is none
	search_value(guid,X),								%% Extract search_value
	write('search_value ': X ), writeln('NOT FOUND!').
bst_handler(guid,(IP,Port),move_to(P)):-
	platform(P,NewIP,NewPort),							%% Extract new Port and IP using P_id
	agent_move(guid,(NewIP,NewPort)).					%% Agent move instruciton

