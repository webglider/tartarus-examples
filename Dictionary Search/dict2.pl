%% Use to initiliaze dictionary platfrom.

%% Dynamic predicates

%% Location of this dictionary
location(localhost, 7002).

%% Words in the dictionary
%% format - word('word', 'meaning')
word(aberration, 'a departure from what is normal, usual, or expected, typically an unwelcome one.').
word(profligate,'recklessly extravagant or wasteful in the use of resources.').
word(belie,'fail to give a true impression of (something).').
word(venerate,'To respect deeply').
word(acrimony,'bitterness and ill will').



%% Use this predicate to initilize the platform.
init :- 
    consult('conf.pl'),
    path_to_tartarus(Path),
    consult(Path),
    location(IP ,Port), platform_start(IP, Port),
    set_token(9595).
