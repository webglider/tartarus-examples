%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%       -- TARTARUS BASICS --         %%
%%                                     %%  
%% Authors: Midhul Varma, Nikhil Teja  %%
%% Last reviewed: 02-08-2015           %%         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ----------------------------INTRODUCTION-------------------------------------
%% This commented prolog file is meant to walk new users through the basics of  
%% the Tartarus Mobile Agent platform. A basic understanding of SWI-Prolog      
%% syntax is assumed. If you don't have this, you first need to learn some
%% prolog. Here are some resources you could use:
%% http://www.swi-prolog.org/pldoc/man?section=quickstart 
%% http://lpn.swi-prolog.org/lpnpage.php?pageid=online
%% http://www.swi-prolog.org/pldoc/doc_for?object=manual

%% While reading through this tutorial try to execute and play around with 
%% the given commands and predicates. Doing so will ensure that you understand
%% the basic features of the platform and how to use them, by the time you 
%% finish reading this document.


%% -----------------------------PLATFORMS---------------------------------------
%% -- What is a platform?
%% A mobile agent is essentially code which migrates from platform to platform.
%% These platforms are special processes which host mobile agents and act as 
%% middleware for the execution of their code safely. Platforms are essentially
%% the nodes of the network in which mobile agents can move.

%% -- Where does a platform run?
%% Every platform runs on a particular machine and reserves a particular port 
%% for it's execution. Port numbers can be in the range [0,65535] but quite a
%% few of these are registered for standard services and hence are not
%% preferable for use. Ports in the range [49152–65535] are reserved for private
%% and custom use and using ports in this range is generally safe.
%% Note that there could be multiple platforms running on the same machine, only
%% they must have different ports. This is very helpful while building and 
%% testing mobile agent applications, as we can emulate the entire network on a
%% single computer.
%% Hence whenever we refer to a network, we mean a collection of platforms each
%% uniquely identified by a <host, port> pair. The `host` is generally the 
%% IP address of the machine on which the platform is running. If all your
%% platforms are running on a single machine it is sufficient to use the term
%% `localhost` as the host.

%% -- How to start a platform?
%% To start a tartarus platform on you machine, you need to open an instance of
%% the SWI-Prolog interpreter and consult the tartarus `platform.pl` file.
%% This file contains all of Tartarus's source code and is the only resource
%% necessary to access all Tartarus features.

%% On Windows systems, this can be done by simply browsing to the directory in 
%% which the `platform.pl` is present and double clicking on it. This will 
%% automatically open an instance of SWI-Prolog and auto consult the pl file.

%% On Unix/Linux systems, this can be done by opening the terminal entering the
%% `swipl` command. This will open the SWI-Prolog interpreter. Then you can 
%% enter the `consult('[path to platform.pl]').` for example if it is located in
%% /home/robotics/tartarus/ then use `consult('/home/tartarus/platform.pl').`

%% Once the file has been consulted on a new instance, you can enter various
%% prolog predicates in the interpreter to execute various platform functions.
%% Using the following predicate we start a new platform on port 50001.
platform_start(localhost, 50001).
%% You could also do the following with the host as your ip address
%% example: platform_start('192.168.0.1', 50001).
%% Note the usage of single quotes around the ip address

%% Now your platform is up and running. To allow mobile agents to come to this
%% platform you need create a token. Tartarus uses a pretty simple 
%% authentication scheme. Every platform has a token or password and any agent
%% which has this token may move to this platform. The token for this platform
%% can be set using:
set_token(9595).
%% The token can be any valid prolog atom. (examples: 'pA$$uuorD', 'abc123')
%% note the single quotes around tokens with special characters.
%% Through out this tutorial we create all platforms with the same token (9595),
%% to keep things simple.


%% If you forget the details of this platform, you can easily get them using the
%% `get_platform_details` predicate. Simply, Enter the following:
get_platform_details(IP,Port), writeln(IP), writeln(Port).
%% The first predicate unifies the two variables to the actual IP and Port and
%% the next two predicates print these values on two lines.

%% -- How to close a platform?
%% To safely close or stop a platform, simply use:
platform_close.

%% Once you have understood these commands and tried them, you can proceed to
%% next section on agents. In the remaining part of this document whenever you
%% see 'setup a platform on port X', you are expected to start the platform on 
%% this port and set the token to 9595.
%% *WARNING: Please do not forget to set the token after you start the platform.
%% Not doing this will not allow any agents to enter your platform.


%% -----------------------------MOBILE AGENTS-----------------------------------
%% -- What is a mobile agent?
%% In Tartarus, it is simply code which can move from platform to platform while
%% modifying itself on the way. Code in prolog simply means a set of predicates.
%% The predicates belonging to an agent must be dynamic (i.e it should be 
%%  possible to delete and reassert these predicates). When a mobile agent moves
%% from platform A to B, essentially A deletes all predicates corresponding to
%% the agent, and these are asserted on B.

%% -- How to create a mobile agent?
%% To create a mobile agent, you essentially have to define a set of predicates
%% which the agent will use for performing various tasks. To do this we create
%% predicates in special format, known as `handlers`. You can think of handlers,
%% as an analogy to functions in a C program. They can be used as sub routines 
%% to perform broken down tasks.
%% Instead of defining separate handlers for each agent, Tartarus gives us the
%% facility of making templates for these handlers. So if you define a handler
%% template, you could create many different agents which use this template.
%% Each agent on creation makes it's own copy of the template handler.
%% We shall now create a very basic agent which simply says "Hello World!".
%% Create a new prolog file `foo.pl` in you favourite editor and start coding.
%% At the top of this file put the following:
:- dynamic foo_handler/3.
%% This statement tells prolog that the predicate `foo_handler` is dynamic i.e
%% it can be asserted and reasserted as required. The number 3 refers to the 
%% arity of the predicate.
%% Next below, we actually define the predicate:
foo_handler(guid, (IP,Port), main) :- 
    writeln('Hello World!'),
    writeln('I am presently at: '),
    writeln(IP),
    writeln(Port).

%% The first term `guid` may sound peculiar. It is simply a keyword which allows
%% for agents to modify the template. The `main` term at the end, indicates that
%% this is the main handler. (like the main function in C). It is called 
%% immediately when an agent starts executing. Back to `guid`. When an agent is
%% created, it simply replaces all occurrences of `guid` in the template with 
%% it's own name. For example if the agents name is `bar`, all occurrences of
%% `guid` will be replaced by `bar`. Hence, it is good enough to think of, guid
%% as the name of the agent holding this predicate. This will become more clear 
%% ahead in the explanation.

%% Now save this file and create a new platform on port 50001 (also set token
%% to 9595). Now consult `foo.pl` on this platform using
%% replace `[path to foo]` with actual path to foo.pl
consult('[path to foo].pl').

%% Now since the code has been loaded, we can create an agent.
agent_create(bar, (localhost, 50001), foo_handler).
%% `bar` is the name of the agent which is being created.
%% `localhost, 50001` is the <host,port> pair on which the agent is to be 
%% created. `foo_handler` specifies the handler template which this agent must 
%% use.

%% So, let's understand what happend during the create process. Since we 
%% specified that the agent must use `foo_handler` template as it's handler,
%% Tartarus, creates a copy of the definition of `foo_handler`, replacing all
%% occurrences of `guid` with `bar`, the name of the agent.
%% To see this, simply type 
listing(foo_handler/3).
%% This command shows all the definitions of the predicate foo_handler.
%% You will see that there are 2 definitions, one the initial generic template
%% definition and the other the same definition with `guid` replaced by `bar`.
%% This later definition is specific to the agent `bar`. If you create another
%% agent with a different name but same handler you will see another definition
%% in the listing.

%% -- How to execute a mobile agent?
%% Now that the agent is created, we can execute it. Execution, means performing
%% the tasks specified in the `main` handler which we had written before. 
%% To execute the agent on this platform run:
agent_execute(bar, (localhost ,50001), foo_handler).
%% You should see "Hello World" followed by the host an port of the present 
%% platform printed

%% -- How to add token to agent?
%% To allow this agent to move to other platforms in the network, you need to 
%% give it a list of tokens. It will then be able to move to platforms, which
%% use any of these token for authentication
%% For this use the predicate
add_token(bar, [9595]).
%% Here we are adding only one token i.e. 9595

%% -- How to generate a unique name for an agent?
%% For consistency, agent names must be unique throughout the network.
%% For this purpose you can use a special predicate which produces unique
%% names.
get_new_name(bar, NewName).
%% The variable new name is unified with a new unique name.
%% The unique name is generated by concatenating a number and platform
%% details to the base name, which in this case is `bar`.
%% So you will get `bar1_localhost_50001` or something similar.



%% -- How to move an agent?
%% Now we come to the important action of moving the agent to other platforms.
%% Agents can autonomously move through the network. To demonstrate this,
%% we shall put the move code within the agent handler.
%% Modify the `foo.pl` file and add some extra lines at the bottom:
foo_handler(guid, (IP,Port), main) :- 
    writeln('Hello World!'),
    writeln('I am presently at: '),
    writeln(IP),
    writeln(Port),
    writeln('About to move'),
    sleep(3), %%sleep for 3 seconds
    agent_move(guid, (localhost, 50002)).

%% Now create another platform on port 50002 and add token as 9595
%% On platform 50001, you need to reconsult `foo.pl` and recreate the agent, as
%% the code has been modified. REMEMBER to add token (9595) to the agent.
%% Don't worry about the old agent, Tartarus will replace it. Once you have 
%% finished doing this, again as before execute the agent.

%% As before the messages will be printed and after a delay of 3 seconds,
%% the agent will move to 50002. You can use the `listing` predicate as before
%% to check that that predicates (in this case only one handler) corresponding
%% to the agent are on the new platform.
%% NOTE: If you see an error saying "agent rejected by target platform", 
%% it means the token has not been set or added properly.


%% -- What is a payload?
%% Apart from handlers one can also attach other predicates to mobile agent's
%% code. These predicates will move along with the agent as it moves through the
%% network. Payload predicates can be used to store data or morphable code.
%% They can be easily added, removed and modified from the agent.

%% -- How to add a payload?
%% Similar to handlers, payloads are also defined through templates. When a 
%% payload is actually added to an agent, the code is copied replacing all
%% occurrences of `guid` by the agent's name.
%% For example to define a payload predicate `test_payload` form the console:
assert(test_predicate(guid, 'hello')).
%% This payload has arity 2, the first term must be `guid` just like for handler
%% Here we are using the second term to store a string (atom) hello.
%% This string can later be modified through agent code.

%% Now to actually add a payload of this template to our agent:
add_payload(bar, [(test_predicate, 2)]).
%% The first argument is the name of the agent to add the payload to.
%% The second argument is a list of (predicate name, arity) tuples.
%% All the predicates in the list will be added as payloads to this agent.
%% Similar to what happens to handlers when a new agent is created,
%% when a payload predicate is added, a copy specific to the particular agent
%% is made. You can see this using:
listing(test_predicate/2).
 
%% If you wish to define payload predicates in a prolog file (.pl), you need
%% to add an extra:
:- dynamic test_predicate/2.
%% at the top of the file, telling prolog that test_predicate must be dynamic.
%% After that you can simply define test_predicate/2, as any normal predicate
%% anywhere in the rest of the code.


%% -- How to modify a payload?
%% The agent might need to modify its own payloads during execution.
%% After all that is what morphability of agent code is all about.
%% If you need an agent to modify a particular payload, you can use the
%% following in the agent code:
agent_handler(guid, (IP, Port), main) :-
%% some other code
retract(test_payload(guid, _)), %% this retracts the old version
assert(test_payload(guid, 'bye')). %% This adds the new version
%% Note: there is no need to add or remove the payload, it is enough to simply,
%% retract and reassert. Tartarus takes care of the rest.

%% -- How to remove a payload?
%% Simply use the `remove_payload` predicate, which has syntax similar to 
%% `add_payload`:
remove_payload(bar, [(test_payload,2)]).

%% -- How to kill an agent?
%% After an agent has finished all it's tasks, it's a good idea to kill it
%% For this use:
agent_kill(bar).



%%-------------------------------END--------------------------------------------
%% This tutorial has covered the basic functionality of the Tartarus mobile 
%% agent platform. For more documentation and other predicates, please refer
%% to the Tartarus manual. All the best for developing Tartarus applications!
