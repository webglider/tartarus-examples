%% Basic example demonstrating basic mobile agent functionality of tartarus

%% handler predicates are used to handle agents in various situations
%% all mobile agent handlers must be declared as dynamic predicates

:- dynamic foo_handler/3.
:- dynamic payload_number/2.
%% structure of the agent handler must be as follows
%% The first parameter must be `guid` This will be replaced by the actual name of
%% the agent when one is created

%% Make sure you create a platform, before tyring to create an agent

%% The main handler is executed by default whenever an agent arrives on a new platform
foo_handler(guid, (IP, Port), main) :- 
    writeln('Hello world, I am foo!').

payload_number(guid,X):-
	X=3;
	X=2;
	X=1.

%% Steps to create an agent
create :- 
    %% get platform details
    get_platform_details(IP, Port),
    agent_create(foo, (IP, Port), foo_handler),
    add_payload(foo,[(payload_number,2)]) ,
    %% We give the agent our token, so it can freely move in and out of this
    %% platform
    add_token(foo, [9595]).
kill:-
	get_platform_details(IP,Port),
	agent_kill(foo).

