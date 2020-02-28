# Discussion 5: Data Types

You will need to implement the following functions in src/d5.ml. Some OCaml relevant modules for this assignment are:
* List
* Random

***flip n***
* Type: int -> head_with_count * tail_with_count
* Description: Flip a coin n times and record how many times it results in a head and how many times it results in a tail.
Use the Random module to generate random integers between 0 and 1 inclusive. Consider 1 head and 0 tail.
* Example: These are based on the preset seed (i.e 0) for the random number generator.
```
    flip 100 = (Head(43), Tail(57))
    flip 0 = (Head(0), Tail(0))
```

***nth_pos lst n***
* Type: 'a list -> int -> 'a option
* Description:  Return the value at postion n in the list. The first postition in the list is 0. If n is beyond bounds, return `None`. Otherwise, return `(Some {value})`. If n is negative, interpret it as an offset from the end of your list modulo the size of your list.
* Example:  
```
    nth_pos [] 0 = None
    nth_pos ['a'; 'b'; 'c'] 1 = (Some 'b')
    nth_pos ['a'; 'b'; 'c'] -1 = (Some 'c')
    nth_pos ['a'; 'b'; 'c'] 5 = None
```