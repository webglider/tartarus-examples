## Insertion Sort (multi-agent)
In this example platforms are arranged sequentially in a linked-list like fashion. Each platform has predicates which define the location of the `left` and `right` platforms. Each platform initially holds a mobile agent which has a particular integer value (held as payload). The integers are initially not in sorted order. The agents intelligently move along with their integers, while coordinating with other agents and finally rearrange themselves into sorted order. They do this in an insertion sort manner. The values at each platform can be checked at each insertion step.


### Usage

Basic setup
________

1. Open the `conf.pl` file and edit the `path_to_tartarus` predicate to point to the location of the Tartarus `platform.pl` in your system.

Setup of platforms
___________________

1. Open 5 instances of SWI-Prolog (swipl) and consult `platform-1.pl`, `platform-2.pl`, .... one on each platform.

2. Run `init.` on each of the platforms. This will initialize the agents.


Insertion
_______________

1. Start from PLATFROM-1 and run `insert.` on each of the platfroms in numerical order (1-5). The `insert.` predicate makes the agent on the present platfrom insert itself into the correct location in sorted order. (other agents may also shift during the process)

2. To view the integer on any particular platfrom at a given point of time, simply run `final_value(X).` X will be unified to the integer which the agent presently on the platform holds. This way you can check the values after every step of insertion.

3. After you have run `insert.` on all platforms in order, the integers and their agents will be in sorted order (increasing left to right).



### Additonal Notes

* The example can easily be extended to more platforms and agents. All you have to do is copy the `platform-1.pl` file and change the required values. Inline comments in the file will help you with this. After this you can simply consult this on a new platfrom and run `init.` and  `insert.` just as usual.

* Insertion must be done in sequential order (the order in which the linked list is arranges left to right).



  
