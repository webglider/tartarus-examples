%% Predicates for city 1
%% Consult this on a platform.

name(paris).

%% Travel price details to various other cities
price(nice, 927).
price(lyon, 457).
price(grenoble, 566).
price(marseille, 769).

init :- 
    consult('conf.pl'),
    consult('locations.pl'),
    path_to_tartarus(Path), consult(Path),
    name(Name), init_platform(Name),
    log_server_details(IP, Port), set_log_server(IP, Port).

