%% Predicates for city 3
%% Consult this on a platform.

name(grenoble).

%% Travel price details to various other cities
price(nice, 334).
price(lyon, 105).
price(paris, 566).
price(marseille, 273).

init :- 
    consult('conf.pl'),
    consult('locations.pl'),
    path_to_tartarus(Path), consult(Path),
    name(Name), init_platform(Name),
    log_server_details(IP, Port), set_log_server(IP, Port).

