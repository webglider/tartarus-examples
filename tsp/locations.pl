%% Locations of cities

location(paris, (localhost, 7001)).
location(nice, (localhost, 7002)).
location(grenoble, (localhost, 7003)).
location(lyon, (localhost, 7004)).
location(marseille, (localhost, 7005)).

%% Predicate to initialize platforms for citites
init_platform(City) :- 
    location(City, (IP, Port)),
    platform_start(IP, Port),
    set_token(9595),
    writeln('********------ ': City :'-----**********').