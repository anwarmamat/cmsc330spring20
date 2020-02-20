let rec map f lst =
    match lst with
    | [] -> []
    | h::t -> (f h)::(map f t)

let rec foldl f acc lst =
    match lst with
    | [] -> acc
    | h::t -> foldl f (f acc h) t

let rec foldr f lst acc =
    match lst with
    | [] -> acc
    | h::t -> f h (foldr f t acc)

(* Return a list containing the integers in the original list increased by 3 *)
let add_three lst =
    failwith "unimplemented"

(* Build a sentence from a list of strings by concatenating the strings from left to right *)
let build_sentence lst =
    failwith "unimplemented"

(* Associate every element in the list with the sum of all the elements in the list *)
let sum_assoc lst =
    failwith "unimplemented"

(* Return the sum of the square of every integer in the list *)
let squared_sum lst =
    failwith "unimplemented"

(* You are given a list of one argument functions to be composed from right to left,
 * i.e the last function should be treated as the innermost function.
 * v is the input to the innermost function.
 * Return the result of the function composition.
 * For example, the code
 *      evaluate [(fun x -> 1 + x); (fun y -> 1 - y); (fun z -> 2 * z)] 5
 * should perform the calculation (1 + (1 - (2 * (5)))) and return -8
 *)
let evaluate funcs x =
    failwith "unimplemented"
