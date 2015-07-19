#Bugs found

1. If first line of the agent handler is negation of a statement, syntax error is raised.


#agent handler
```
:- dynamic test/3.

test(guid,(IP,Port),main):-
        (\+number(a)),
        writeln("nope").

```
#Error raised
```
ERROR: Syntax error: Operator expected
ERROR: test(guid, (_G1465,_G1466),main
ERROR: ** here **
ERROR: ):-\+numeber(a),writeln([110,111,112,101]) . 

```

#Observations

Error can be avoided by adding a dummy first line in the handler say `true` as follows
```
:- dynamic test/3.

test(guid,(IP,Port),main):-
		true,
        (\+number(a)),
        writeln("nope").
```