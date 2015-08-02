
:- dynamic spawn_agent_handler/3.
:- dynamic layer_number/2.



%% Handler for each new agent created. 
%% Executed on transfer to its destination.

spawn_agent_handler(guid,(IP,Port),main):-
	current_predicate(visited/1),						%% If visited predicate exists on the platform.
	agent_kill(guid).

spawn_agent_handler(guid,(IP,Port),main):-
writeln('fuck you'),
	true,
	\+current_predicate(visited/1),						%% If visited predicate doesn't exists on the platform.
	assert(visited(guid)),								%% If not visited predicate doesn't exist,
	platform(P_id , IP , Port),							%% asssert the platform as visited,
	neighbors(P_id,L),									%% and spawn new agents to the neighbors of the platform.
	write('ready to spawn from ': P_id),
	writeln(' to platforms ': L),
	sleep(2),
	spawn_agent_handler(guid,(IP,Port),spawn_to_platforms(P_id,L)).


%% This predicate recursively goes through the platforms neighboring to P and calls spawn() on each elements.

spawn_agent_handler(guid, (IP , Port), spawn_to_platforms(P,[])).
spawn_agent_handler(guid, (IP , Port),spawn_to_platforms(P,[H|T])):-
	write('spawn from ': P),
	writeln(' to ': H),
	spawn_agent_handler(guid,(IP,Port),spawn(P,H)),					%% Extracting head of the list.
	spawn_agent_handler(guid,(IP,Port),spawn_to_platforms(P,T)).	%% recursively reading the remaining elements of the list.	
																	

%% Creates a new agent to send to a neighboring node 'P_to' from the present node 'P_from'.

spawn_agent_handler(guid,(IP,Port),spawn(P_from,P_to)):-
	atom_concat(P_from,'_to_',Temp),
	atom_concat(Temp,P_to,New_agent_name),							%% generating new name.
	writeln('spawned the agent ' : New_agent_name),
	platform(P_from,IP1,Port1),
	agent_create(New_agent_name,(IP1,Port1),spawn_agent_handler),	%% Creating new agent for sending to P_to.
	layer_number(guid,N),
	X is N+1 ,
	%%writeln('layer number is ' : X),								
	assert(layer_number(New_agent_name,X)),
	add_payload(New_agent_name,[(layer_number,2)]),					%% adding payload containing the layer number of the node.
	add_token(New_agent_name , [9595]),								%% Adding token before moving to new platform.
	platform(P_to,IP2,Port2),
	agent_move(New_agent_name,(IP2,Port2)).							%% Moving to new platform.


