%% Example demonstrating basic setup of tartarus platform

setup :- 
    %% Consulting the tartarus platform file
    %% Replace path with actual location of this file on your system
    consult('path-to-platform.pl'),

    %% Starting a new platform
    %% This starts a new platform on the 3434 port of your machine
    %% The host and port pair is used for identification of the platform
    platform_start(localhost, 3434),

    %% Token must be set for authentication
    %% Only agents which have this token can enter your platform
    %% Like a secret passcode
    set_token(9595),

    %% Getting details of platform
    get_platform_details(IP, Port),
    %% Printing them
    writeln(IP), writeln(Port).