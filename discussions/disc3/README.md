# Discussion 3: Introduction to OCaml

Due: February 16 at 11:59:59 PM
Points: 100SP

You will need to implement the following functions in the **src/d3.ml** file. We have not provided any public tests, so you'll have to write your own tests to make sure that your code works as you expect it to.

### Submitting
You will submit this project to [Gradescope](https://www.gradescope.com/).  Click on the "D3" assignment and submit _only_ your **d3.ml** file in the **src** directory.  Don't zip your solution.  Any files other than **d3.ml** will be ignored.

## Part 1: Type Inference Exercises

At the top of **src/d3.ml**, there are a few function definitions. Try determining the types of these functions and check your answers with utop. This portion of the discussion is not tested, but these kinds of exercises may appear on quizzes and exams!

## Part 2: Function Exercises

#### concat str1 str2
- **Type**: `string -> string -> string`
- **Description**: Appends `str2` to the end of `str1`.
- **Examples:**
```
concat "" "" = ""
concat "" "abc" = "abc"
concat "xyz" "" = "xyz"
concat "abc" "xyz" = "abcxyz"
```

#### add_to_float integer flt
- **Type**: `int -> float -> float`
- **Description**: Adds `integer` and `flt` and returns a float representation of the sum.
- **Examples:**
```
add_to_float 3 4.8 = 7.8
add_to_float 0 0.0 = 0.0
```

#### fib n
- **Type**: `int -> int`
- **Description**: Calculates the nth [Fibonacci number](https://en.wikipedia.org/wiki/Fibonacci_number).
- **Examples:**
```
fib 0 = 0
fib 1 = 1
fib 2 = 1
fib 3 = 2
fib 6 = 8
```

## Part 3: List and Tuple Exercisees

#### add_three lst
- **Type**: `int list -> int list`
- **Description**: Adds 3 to each element in `lst`
- **Examples:**
```
add_three [] = []
add_three [1] = [4]
add_three [1; 3; 5] = [4; 6; 8]
```

#### filter f lst
- **Type**: `('a -> bool) -> 'a list -> 'a list`
- **Description**: Given a function `f` and a list `lst`, Remove elements from `lst` that do not return true when passed into `f`.
- **Examples:**
```
filter (fun a -> a = 3) [1; 2; 3; 3; 2; 1] = [3; 3]
filter (fun a -> a mod 2 = 0) [1; 2; 3; 4] = [2; 4]
```

#### zip lst1 lst2
- **Type**: `float list -> float list -> (float * float) list`
- **Description**: Given two lists of floats, `lst1` and `lst2`, return a list of tuples each containing two floats, one from the corresponding index of either list.
- **Assumptions**: `lst1` and `lst2` are the same length.
- **Examples:**
```
zip [] [] = []
zip [1.0; 2.0] [3.0; 4.0] = [(1.0, 3.0); (2.0, 4.0)]
```
