%% Predicates for city 2
%% Consult this on a platform.

name(nice).

%% Travel price details to various other cities
price(paris, 927).
price(lyon, 471).
price(grenoble, 334).
price(marseille, 185).

init :- 
    consult('conf.pl'),
    consult('locations.pl'),
    path_to_tartarus(Path), consult(Path),
    name(Name), init_platform(Name),
    log_server_details(IP, Port), set_log_server(IP, Port).

