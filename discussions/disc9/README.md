## Discussion 9 - CMSC330 Spring 2020

# Parsing

Implement the following function in parser.ml.

***parser toks***
* Type: token list -> expr
* Description: Given a token list, generate and return an abstract syntax tree of type expr that represents the token list.
* Examples: 
```
    parser [Tok_Int(5); Tok_Mult; Tok_Int(6)] = Mult(5, 6)
    parser [Tok_Int(5); Tok_Plus; Tok_Int(6); Tok_Mult; Tok_Int(7)] = Add(5, Mult(6, 7))
    parser [Tok_Int(5); Tok_Plus; Tok_Int(6); Tok_Mult] should fail.
```

