open OUnit2
open D4

let test1 _ =
    assert_equal 1 1

let suite =
    "student" >::: [
        "test1" >:: test1
    ]

let () =
    run_test_tt_main suite
