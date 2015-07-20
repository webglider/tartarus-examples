%% Predicates for city 4
%% Consult this on a platform.

name(lyon).

%% Travel distance details to various other cities
price(nice, 471).
price(paris, 457).
price(grenoble, 105).
price(marseille, 314).

init :- 
    consult('conf.pl'),
    consult('locations.pl'),
    path_to_tartarus(Path), consult(Path),
    name(Name), init_platform(Name),
    log_server_details(IP, Port), set_log_server(IP, Port).

