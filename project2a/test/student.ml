open OUnit2

(* This is an example test.  You can modify it or add new ones to test your code *)
let test_sanity ctxt = 
  assert_equal 1 1

(* Make sure you update the list of tests here so that your test is actually run *)
let suite =
  "student" >::: [
    (* Each line contains the name of the test in quotes, followed by >::, and finally the name of the test function *)
    "sanity" >:: test_sanity
  ]

(* You don't need to modify this line *)
let _ = run_test_tt_main suite
