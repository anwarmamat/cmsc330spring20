open OUnit2
open D4

let test_add_three _ =
    assert_equal [13; 15] (add_three [10; 12]);
    assert_equal [3; 2] (add_three [0; (-1)])

let test_build_sentence _ =
    assert_equal "I am inevitable" (build_sentence ["I "; "am "; "inevitable"]);
    assert_equal "I am Iron Man" (build_sentence ["I "; "am "; "Iron "; "Man"])

let test_sum_assoc _ =
    assert_equal [(0, 3); (1, 3); (2, 3)] (sum_assoc [0; 1; 2]);
    assert_equal [(0, 0); (0, 0); (0, 0)] (sum_assoc [0; 0; 0])

let test_squared_sum _ =
    assert_equal 5 (squared_sum [1; 2]);
    assert_equal 5 (squared_sum [0; 1; 2; 0])

let test_evaluate _ =
    assert_equal (2) (evaluate [((+) 1); ((-) 1)] 0);
    assert_equal (-19) (evaluate [((-) 1); (( * ) 2)] 10)

let suite =
    "public" >::: [
        "public_add_three" >:: test_add_three;
        "public_build_sentence" >:: test_build_sentence;
        "public_sum_assoc" >:: test_sum_assoc;
        "public_squared_sum" >:: test_squared_sum;
        "public_evaluate" >:: test_evaluate
    ]

let () =
    run_test_tt_main suite
