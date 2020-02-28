open D5
open OUnit2

let test_flip _=
    assert_equal (flip 100) (Head(43), Tail(57));
    assert_equal (flip 200) (Head(88), Tail(112));
    assert_equal (flip 0) (Head(0), Tail(0))

let test_nth_pos _= 
    let lst = [1;2;3] in
    assert_equal (nth_pos lst 0) (Some 1);
    assert_equal (nth_pos lst (-2)) (Some 2);
    assert_equal (nth_pos lst 1) (Some 2);
    assert_equal (nth_pos lst 4) None;
    assert_equal (nth_pos [] 0) None

let suite = 
    "public" >::: [
        "flip" >:: test_flip;
        "nth_pos" >:: test_nth_pos
    ]
    
let () = 
    run_test_tt_main suite


