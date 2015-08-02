%% Use to initiliaze dictionary platfrom.

%% Dynamic predicates

%% Location of this dictionary
location(localhost, 7003).

%% Words in the dictionary
%% format - word('word', 'meaning')
word(amorphous, 'adjective for shapeless').
word(ingenuous,'being naive or innocent').
word(disinterested,'unbiased ; neutral').
word(upbraid,'to reproach or scold').
word(galvanize,'to excite or inspire to action').



%% Use this predicate to initilize the platform.
init :- 
    consult('conf.pl'),
    path_to_tartarus(Path),
    consult(Path),
    location(IP ,Port), platform_start(IP, Port),
    set_token(9595).
