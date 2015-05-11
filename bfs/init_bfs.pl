

init1 :-
	consult('platform.pl'),
	consult('bfs.pl'),
	platform_start(localhost,3000),
	set_token(9595),
	agent_create(ant,(localhost,3000),spawn_agent_handler),
	add_token(ant,[9595]),
	assert(layer_number(guid,0)),
	add_payload(ant,[(layer_number,2)]).

start:-
	agent_execute(ant,(localhost,3000),spawn_agent_handler).

init2:-
	consult('platform.pl'),
	consult('bfs.pl'),
	platform_start(localhost,3001),
	set_token(9595).

init3:-
	consult('platform.pl'),
	consult('bfs.pl'),
	platform_start(localhost,3002),
	set_token(9595).

init4:-
	consult('platform.pl'),
	consult('bfs.pl'),
	platform_start(localhost,3003),
	set_token(9595).

init5:-
	consult('platform.pl'),
	consult('bfs.pl'),
	platform_start(localhost,3004),
	set_token(9595).

