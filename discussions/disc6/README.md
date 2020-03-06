# Discussion 6: Data Types and References

You will need to implement the following functions in src/d6.ml.

***insert_at_tail x***
* Type: int -> unit
* Description: Insert the provided integer at the tail of the linked list. You should change the state of the list variable defined
for you in the process. Implement this function by following the chain of references like you would in C.
* Examples: 
```
    list starts as {contents = Null}

    insert_at_tail 1;;
    list should now be {contents = Value (1, {contents = Null})} 

    insert_at_tail 5;
    list should now be {contents = Value (1, {contents = Value (5, {contents = Null})})}

```

***length ()***
* Type: unit -> int
* Description:  Return the number of values in the linked list.
* Examples:  
```
    list starts as {contents = Null}
    length() is  0

    insert_at_tail 1;;
    list should now be {contents = Value (1, {contents = Null})}
    length should now be 1 

    insert_at_tail 5;
    list should now be {contents = Value (1, {contents = Value (5, {contents = Null})})}
    length should now be 2
```