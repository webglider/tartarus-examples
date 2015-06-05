%% Use to initiliaze dictionary platfrom.

%% Dynamic predicates

%% Location of this dictionary
location(localhost, 7001).

%% Words in the dictionary
%% format - word('word', 'meaning')
word(ingenious, 'cleverly and originally devised and well suited to its purpose').
word(hypothetical, 'based on or serving as a hypothesis').
word(gigantic, 'of very great size or extent; huge or enormous').
word(superfluous, 'unnecessary, especially through being more than enough').
word(retarded, 'less advanced in mental, physical, or social development than is usual for ones age').


%% Use this predicate to initilize the platform.
init :- 
    consult('conf.pl'),
    path_to_tartarus(Path),
    consult(Path),
    location(IP ,Port), platform_start(IP, Port),
    set_token(9595).