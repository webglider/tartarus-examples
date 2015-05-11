## Sum collector (mobile agent)
This examples demonstrates a mobile agent which starts from a platform and moves through a series of platforms while collecting values and accumulates the sum of these values. The accumulated values are stored in a payload predicate `result` which is carried along with the agent as it moves.

### Usage
1. Copy the Tartarus platform file into the directory of this example as `platform.pl`.

2. Open 4 instantiations of swi-prolog, run `consult('init.pl').` on each of them. (This can be done on windows by directly double clicking on the init.pl file)

3. Run the predicates `init.`, `init1.`, `init2.`, `init3.`, one on each of the platforms.

4. On the platform running at 3434 (starting point) run the `start.` predicate

5. Agent will now move through the other three platforms pick the corresponding values and will return to the starting point and then print the final sum.

