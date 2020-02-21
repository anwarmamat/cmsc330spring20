# Discussion 4: Higher Order Functions
Due: February 23 at 11:59:59 PM Points: 50P/50SP

You will need to implement the following functions in src/d4.ml. Map and Fold have been implemented for you. Use them to implement all the functions on this assignment.

## Submitting
You will submit this project to Gradescope. Click on the "D4" assignment and submit only your **d4.ml** file in the src directory. Don't zip your solution. ***Any files other than d4.ml will be ignored***.

# Map And Fold Exercises
#### add_three lst
- **Type:** `int list -> int list`
- **Description:** Return a list containing the integers in lst increased by 3.
- **Examples:**
```ocaml
    add_three [0] = [3];;
    add_three [4; 5; 6] = [7; 8; 9];;
    add_three [] = [];;
 ```

#### build_sentence lst
- **Type:** `string list -> string`
- **Description:** Build a sentence from a list of strings by concatenating the strings from left to right.  You do not have to add spaces between the words, they will be included already.
- **Examples:**
```ocaml
    build_sentence [] = [];;
    build_sentence ["How"] = "How";;
    build_sentence ["How"; " are"; " you?"] = "How are you?";;
 ```

#### sum_assoc lst
- **Type:** `int list -> (int * int) list`
- **Description:** Associate every element in the list with the total sum of all the elements in the list.
- **Examples:**
```ocaml
    sum_assoc [] = [];;
    sum_assoc [6] = [(6, 6)];;
    sum_assoc [5; 6; 7] = [(5, 18); (6, 18); (7, 18)];;
 ```

#### squared_sum lst
- **Type:** `int list -> int`
- **Description:** Return the sum of the square of every integer in the list.
- **Examples:**
```ocaml
    squared_sum [] = 0;;
    squared_sum [4; 5] = 41;;
 ```

#### evaluate lst v
- **Type:** `(int -> int) list -> int -> int`
- **Description:** You are given a list of one argument functions to be composed from right to left i.e the last function should be treated as the innermost function. v is the input to the innermost function. Return the result of the function composition.
- **Examples:**
```ocaml
    evaluate [] 27 = 27;;
    evaluate [(fun x -> x + 1); (fun y -> y * 4)] 5 = 21;;
    evaluate [
      (fun a -> a + 3);
      (fun b -> 3 - b);
      (fun c -> 2 + c);
      (fun d -> 2 - d)
    ] 0 = 2;;
 ```
