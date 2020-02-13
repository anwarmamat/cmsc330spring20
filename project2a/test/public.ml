open OUnit2
open Basics

let test_rev_tup ctxt =
  assert_equal (1, 2, 3) (rev_tup (3, 2, 1)) ~msg:"rev_tup (1)";
  assert_equal (3, 2, 1) (rev_tup (1, 2, 3)) ~msg:"rev_tup (2)";
  assert_equal (3, 1, 1) (rev_tup (1, 1, 3)) ~msg:"rev_tup (3)";
  assert_equal (1, 1, 1) (rev_tup (1, 1, 1)) ~msg:"rev_tup (4)"

let test_abs ctxt =
  assert_equal 1 (abs 1) ~msg:"abs (1)";
  assert_equal 1 (abs (-1)) ~msg:"abs (2)";
  assert_equal 13 (abs 13) ~msg:"abs (3)";
  assert_equal 13 (abs (-13)) ~msg:"abs (4)"

let test_area ctxt =
  assert_equal 1 (area (1, 1) (2, 2)) ~msg:"area (1)";
  assert_equal 2 (area (1, 1) (2, 3)) ~msg:"area (2)";
  assert_equal 2 (area (1, 1) (3, 2)) ~msg:"area (3)";
  assert_equal 4 (area (1, 1) (3, 3)) ~msg:"area (4)"

let test_volume ctxt =
  assert_equal 1 (volume (1, 1, 1) (2, 2, 2)) ~msg:"volume (1)";
  assert_equal 4 (volume (1, 1, 1) (2, 3, 3)) ~msg:"volume (2)";
  assert_equal 4 (volume (1, 1, 1) (3, 2, 3)) ~msg:"volume (3)";
  assert_equal 4 (volume (1, 1, 1) (3, 3, 2)) ~msg:"volume (4)";
  assert_equal 8 (volume (1, 1, 1) (3, 3, 3)) ~msg:"volume (5)"

let test_equiv_frac ctxt =
  assert_equal true (equiv_frac (1, 2) (2, 4)) ~msg:"equiv_frac (1)";
  assert_equal true (equiv_frac (2, 4) (1, 2)) ~msg:"equiv_frac (2)";
  assert_equal true (equiv_frac (1, 2) (1, 2)) ~msg:"equiv_frac (3)";
  assert_equal true (equiv_frac (3, 6) (2, 4)) ~msg:"equiv_frac (4)";
  assert_equal false (equiv_frac (1, 3) (2, 5)) ~msg:"equiv_frac (5)";
  assert_equal false (equiv_frac (10, 30) (4, 6)) ~msg:"equiv_frac (6)";
  assert_equal false (equiv_frac (999999999, 1000000000) (999999998, 1000000000)) ~msg:"equiv_frac(7)"

let test_factorial ctxt =
  assert_equal 1 (factorial 1) ~msg:"factorial (1)";
  assert_equal 2 (factorial 2) ~msg:"factorial (2)";
  assert_equal 6 (factorial 3) ~msg:"factorial (3)";
  assert_equal 120 (factorial 5) ~msg:"factorial (4)"

let test_pow ctxt =
  assert_equal 2 (pow 2 1) ~msg:"pow (1)";
  assert_equal 4 (pow 2 2) ~msg:"pow (2)";
  assert_equal 3 (pow 3 1) ~msg:"pow (3)";
  assert_equal 27 (pow 3 3) ~msg:"pow (4)";
  assert_equal 625 (pow 5 4) ~msg:"pow (5)";
  assert_equal (-27) (pow (-3) 3) ~msg:"pow (6)"

let test_tail ctxt =
  assert_equal 5 (tail 125 1) ~msg:"tail (1)";
  assert_equal 25 (tail 125 2) ~msg:"tail (2)";
  assert_equal 125 (tail 125125 3) ~msg:"tail (3)"

let test_len ctxt =
  assert_equal 1 (len 4) ~msg:"len (1)";
  assert_equal 3 (len 330) ~msg:"len (2)";
  assert_equal 4 (len 1000) ~msg:"len (3) ";
  assert_equal 6 (len 100000) ~msg:"len (4)"

let test_contains ctxt =
  assert_equal false (contains 4 5) ~msg:"contains (1)";
  assert_equal true (contains 30 330) ~msg:"contains (2)";
  assert_equal false (contains 200 10020) ~msg:"contains (3)";
  assert_equal true (contains 10001 100010) ~msg:"contains (4)";
  assert_equal false (contains 100010 10001) ~msg:"contains (5)"

let test_get ctxt =
  assert_equal 26 (get 0 [26; 11; 99]) ~msg:"get (1)";
  assert_equal 11 (get 1 [26; 11; 99]) ~msg:"get (2)";
  assert_equal 99 (get 2 [26; 11; 99]) ~msg:"get (3)";
  assert_raises (Failure ("Out of bounds")) (fun () -> get 3 [26; 11; 99]) ~msg:"get (4)"

let test_reverse ctxt =
  assert_equal [1] (reverse [1]) ~msg:"reverse (1)";
  assert_equal [3; 2; 1] (reverse [1; 2; 3]) ~msg:"reverse (2)"

let test_combine ctxt =
  assert_equal [1; 2] (combine [1] [2]) ~msg:"combine (1)";
  assert_equal [1; 2; 3] (combine [1] [2; 3]) ~msg:"combine (2)";
  assert_equal [1; 2; 3] (combine [1; 2] [3]) ~msg:"combine (3)";
  assert_equal [1; 2; 3; 4] (combine [1; 2] [3; 4]) ~msg:"combine (4)"

let suite =
  "public" >::: [
    "rev_tup" >:: test_rev_tup;
    "abs" >:: test_abs;
    "area" >:: test_area;
    "volume" >:: test_volume;
    "equiv_frac" >:: test_equiv_frac;
    "factorial" >:: test_factorial;
    "pow" >:: test_pow;
    "tail" >:: test_tail;
    "len" >:: test_len;
    "contains" >:: test_contains;
    "get" >:: test_get;
    "reverse" >:: test_reverse;
    "combine" >:: test_combine
  ]

let _ = run_test_tt_main suite
