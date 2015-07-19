:- dynamic test_handler/3.

test_handler(guid,(IP,Port),main):-
	writeln("Moved.").


test(spawner,Recieving_host):-
	[platform],
	platform_start(localhost,5000),
	set_token(9595),
	agent_create(test_agent,(localhost,5000),test_handler),
	add_token(test_agent,[9595]),
	writeln("moving..."),
	agent_move(test_agent,(Recieving_host,5000)),
	writeln("moved.").

test(reciever):-
	[platform],
	platform_start(localhost,5000),
	set_token(9595).