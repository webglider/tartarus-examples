:- dynamic test_handler/3.


test_handler(guid,(IP,Port),main):-
	\+number(a),
	writeln("nope").

test:-
	[platform],
	platform_start(localhost,5000),
	agent_create(test_agent,(IP,Port),test_handler),
	writeln("agent created with no errors").
