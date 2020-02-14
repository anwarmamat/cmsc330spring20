open OUnit2
(* open D3 *)

let test1 _  =
    assert_equal 3 3

let test2 _ =
    assert_equal "hi" "hi"

let suite =
    "student" >::: [
        "test1" >:: test1;
        "test2" >:: test2
    ]

let () =
    run_test_tt_main suite
