%% Predicates for city 5
%% Consult this on a platform.

name(marseille).

%% Travel price details to various other cities
price(nice, 185).
price(lyon, 314).
price(grenoble, 273).
price(paris, 769).

init :- 
    consult('conf.pl'),
    consult('locations.pl'),
    path_to_tartarus(Path), consult(Path),
    name(Name), init_platform(Name),
    log_server_details(IP, Port), set_log_server(IP, Port).

