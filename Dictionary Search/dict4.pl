%% Use to initiliaze dictionary platfrom.

%% Dynamic predicates

%% Location of this dictionary
location(localhost, 7004).

%% Words in the dictionary
%% format - word('word', 'meaning')
word(wanting, 'lacking').
word(artful, 'exhibiting artisitc skill').
word(undermine,'to weaken').
word(involved,'complicated ; and difficult to comprehend').
word(harangue,'a long pompous speech; a tirade').



%% Use this predicate to initilize the platform.
init :- 
    consult('conf.pl'),
    path_to_tartarus(Path),
    consult(Path),
    location(IP ,Port), platform_start(IP, Port),
    set_token(9595).
