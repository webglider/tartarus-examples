%% Configuration file

%% Path to tartarus `platform.pl` file
path_to_tartarus('../../platform.pl').

%% Command to open new instance of swi prolog
%% This should be the format of the Command
%% Note: the terms in <> brackets will be replaced by the setup script
swipl_command('gnome-terminal --command "swipl -s init.pl -g <command>"').

%% Base port (base portno to start from)
%% Base port = 7000 => platforms will be 7001, 7002, ... so on
base_port(10000).

%% Size of grid (rowsxcolumns)
grid_size(5,5).

%% Set of jammed nodes
%% Note: If none keep only null entry
jammed_node(null,null).
jammed_node(3,1).
jammed_node(4,1).
jammed_node(5,1).
jammed_node(1,2).
jammed_node(1,3).
jammed_node(2,3).
jammed_node(4,3).
jammed_node(4,4).
jammed_node(5,4).
