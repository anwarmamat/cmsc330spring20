open OUnit2
open D6

let test_linked_list _ = 
    assert_equal (length ()) 0;
    insert_at_tail 6;
    insert_at_tail 7;
    assert_equal (length ()) 2;
    insert_at_tail 60;
    insert_at_tail (-5);
    assert_equal (length ()) 4

let suite = 
    "public" >::: [
        "general_test" >:: test_linked_list
    ]

let () = run_test_tt_main suite
