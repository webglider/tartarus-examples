#Bug found

Agent gives and error on recieving platform when moved to a platform on a foriegn host machine with a port number different from the parent platform port. ie if the port and ip of the recieving platform are different from the sending platform.

#How to view the bug

1. Consult `agent_move.pl` by executing the command `swipl -s agent_move.pl` on two different host machines.
2. On the recieving machine execute the predicate test(reciever).
3. On the spawning machine execute the prediate `test(spawner,<recieving hostname>)`.

#Error found

On the recieving machine the following message is displayed.
```
Agent bearing test_agent has arrived to this platform. 
error(socket_error(Connection refused),_G216)
ERROR: [Thread 5] Unknown message: agent_post(platform,(Ip_receiver,Port_receiver),FunctionList) failed
ERROR: [Thread 5] Unknown message: Error in handler. The posted agent not received properly over the Link


```


