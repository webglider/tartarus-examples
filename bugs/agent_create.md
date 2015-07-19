#Bug description

If first line of the agent handler is negation of a statement, syntax error is raised.


#Agent handler code

```
:- dynamic test_handler/3.

test_handler(guid,(IP,Port),main):-
        (\+number(a)),
        writeln("nope").

```
#Error raised
```
ERROR: Syntax error: Operator expected
ERROR: test_handler(guid, (_G1465,_G1466),main
ERROR: ** here **
ERROR: ):-\+numeber(a),writeln([110,111,112,101]) . 

```

#Observations and Alternatives

Error can be avoided by adding a dummy first line in the handler say `true` as follows
```
:- dynamic test_handler/3.

test_handler(guid,(IP,Port),main):-
		true,
        (\+number(a)),
        writeln("nope").
```

Error can also be avoided by using the predicate `not/1` instead of `\+` operator
```
:- dynamic test_handler/3.

test_handler(guid,(IP,Port),main):-
        not(number(a)),
        writeln("nope").
```
Note: 
`not/1` is allowed in swi-prolog for compatibility purposes only and hence not advisable.