## Tic-Tac-Toe (multiplayer)
This example demonstrates the implementation of a simple multiplayer tic-tac-toe game with the help of a mobile agent. Each player in the game is connected in the network and has a tartarus platform running. A mobile agent which acts as a referee for the game moves from player to player in the order of turns. When it reaches a particular player, it prints the present state of the board, and allows him/her to make the next move. When the player makes a move, the agent moves on to the next player and continues the process. The agent is intelligent and can logically deduce when someone wins or loses. (Prolog makes the implementation of the tic-tac-toe logic very simple)

### Usage
Both the players should have tartarus platforms running on their respective hosts (either on same computer or different ones connected through a network). Instructions for setup of the platforms are as follows:

Player 1
________

1. Consult the Tartarus platform file `platform.pl` from appropriate location using either `consult('path to platform.pl').` or the Windows GUI

2. Start a platform using `platform_start(host1, port1).`, replace host1 and port1 with required values. (host is simply localhost if running locally)

3. Set token to 9595 using `set_token(9595).` (Note: the value 9595 is hardcoded in the `play.pl` file and it can be modified if required)

4. Consult the `agent.pl` and `play.pl` files given with this example, in the same way as in step 1

5. Set the opponent player as player 2 using `assert(play_with(host2, port2)).` where host2 and port2 are respectively the host and port of the opponent player.

Player 2
________

1. Consult the Tartarus platform file `platform.pl` from appropriate location using either `consult('path to platform.pl').` or the Windows GUI

2. Start a platform using `platform_start(host2, port2).`, replace host2 and port2 with required values. (host is simply localhost if running locally)

3. Set token to 9595 using `set_token(9595).` (Note: the value 9595 is hardcoded in the `play.pl` file and it can be modified if required)

4. Set the opponent player as player 1 using `assert(play_with(host1, port1)).` where host1 and port1 are respectively the host and port of player 1.

Instructions for playing
_______________________

* The game can be started by player 1 using `start.`

* To make a move at a particular location you must enter input of row and column as asked by the newly created console. REMEMBER to add a full-stop i.e . after immediately after your input

* The agent will move from player to player alternatively until somebody wins or there are no leftover valid moves


### Additional Notes
* The `play_with(host, port)` predicate is used to guide the agent to the next player in the sequence. Though the above instructions are for two players, the sequence can easily be extended to more players (even number in alternating sequence of symbols)

* The agent originates from player 1 (wherever the `start` predicate is called) and moves from there onwards

* The state of the board is carried by the agent as payload as it moves through the network from player to player
