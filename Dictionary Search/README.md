## Dictionary Search
This is a simple example demonstrating dictionary search. Dictionaries of english words along with their meaning are stored on several dictionaries each on a separate platform on the network. A user who would like to search for a word, does so by creating a mobile agent which moves through each of the dictionaries one after another until it finds the word and returns to the home platform with the meaning, printing it to the user. The agent kills itself after the process is completed.


### Usage

1. Open the `conf.pl` file and edit the `path_to_tartarus` predicate to point to the location of the Tartarus `platform.pl` in your system.

2. Open an instance of SWI-Prolog (swipl) and consult `home.pl`.

3. Run `init.` to initialize the home platform.

4. Open 5 other instances of SWI-Prolog (swipl) and consult `dict1.pl`, `dict2.pl` ....... `dict5.pl`.

5. Run `init.` to initialize the dictionary platform on each of the instances.

6. On the home platform run `search.`, to search a word.

7. Enter the word as input and use full-stop (.) to terminate. (Example: hypothetical.)

8. Agent will search the dictionaries and print the meaning if found.

9. You can repeat the process by running `search.` again.


### Additional Notes

* The words in each dictionary are stored in the corresponding `dict*.pl` file with the `word(word,meaning)` predicates.

* New dictionaries can easily be added to the example. To do so simply create a copy of the `dict1.pl` file and make the required modifications. Also in `home.pl` add the location of the new dictionary to the agent's list with the help of the `list` predicate.

