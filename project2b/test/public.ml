open OUnit2
open TestUtils
open P2b.Data
open P2b.Funs
open P2b.Higher

let public_count_occ ctxt =
  let y = ["a";"a";"b";"a"] in
  let z = [1;7;7;1;5;2;7;7] in
  let a = [true;false;false;true;false;false;false] in
  let b = [] in

  assert_equal ~printer:string_of_int_pair (3,1) @@ (count_occ y "a", count_occ y "b");
  assert_equal ~printer:string_of_int_quad (2,4,1,1) @@ (count_occ z 1, count_occ z 7, count_occ z 5, count_occ z 2);
  assert_equal ~printer:string_of_int_pair (2,5) @@ (count_occ a true, count_occ a false);
  assert_equal ~printer:string_of_int_pair (0,0) @@ (count_occ b "a", count_occ b 1)

let public_uniq ctxt =
  let y = ["a";"a";"b";"a"] in
  let z = [1;7;7;1;5;2;7;7] in
  let a = [true;false;false;true;false;false;false] in
  let b = [] in
  let cmp x y = if x < y then (-1) else if x = y then 0 else 1 in

  assert_equal ~printer:string_of_string_list ["a";"b"] @@ List.sort cmp (uniq y);
  assert_equal ~printer:string_of_int_list [1;2;5;7] @@ List.sort cmp (uniq z);
  assert_equal ~printer:string_of_bool_list [false;true] @@ List.sort cmp (uniq a);
  assert_equal ~printer:string_of_int_list [] @@ uniq b

let public_assoc_list ctxt =
  let y = ["a";"a";"b";"a"] in
  let z = [1;7;7;1;5;2;7;7] in
  let a = [true;false;false;true;false;false;false] in
  let b = [] in
  let cmp x y = if x < y then (-1) else if x = y then 0 else 1 in

  assert_equal ~printer:string_of_string_int_pair_list [("a",3);("b",1)] @@ List.sort cmp (assoc_list y);
  assert_equal ~printer:string_of_int_pair_list [(1,2);(2,1);(5,1);(7,4)] @@ List.sort cmp (assoc_list z);
  assert_equal ~printer:string_of_bool_int_pair_list [(false,5);(true,2)] @@ List.sort cmp (assoc_list a);
  assert_equal ~printer:string_of_int_pair_list [] @@ assoc_list b

let public_int_tree ctxt =
  let t0 = empty_int_tree in
  let t1 = (int_insert 3 (int_insert 11 t0)) in
  let t2 = (int_insert 13 t1) in
  let t3 = (int_insert 17 (int_insert 3 (int_insert 1 t2))) in

  assert_equal ~printer:string_of_int 0 @@ (int_size t0);
  assert_equal ~printer:string_of_int 2 @@ (int_size t1);
  assert_equal ~printer:string_of_int 3 @@ (int_size t2);
  assert_equal ~printer:string_of_int 5 @@ (int_size t3);

  assert_raises (Invalid_argument("int_max")) (fun () -> int_max t0);
  assert_equal ~printer:string_of_int 11 @@ int_max t1;
  assert_equal ~printer:string_of_int 13 @@ int_max t2;
  assert_equal ~printer:string_of_int 17 @@ int_max t3

let public_int_common_1 ctxt =
  let p0 = empty_int_tree in
  let p1 = (int_insert 2 (int_insert 5 p0)) in
  let p3 = (int_insert 10 (int_insert 3 (int_insert 11 p1))) in
  let p4 = (int_insert 15 p3) in
  let p5 = (int_insert 1 p4) in

  assert_equal ~printer:string_of_int 5 @@ int_common p5 1 11;
  assert_equal ~printer:string_of_int 5 @@ int_common p5 1 10;
  assert_equal ~printer:string_of_int 5 @@ int_common p5 2 10;
  assert_equal ~printer:string_of_int 2 @@ int_common p5 2 3;
  assert_equal ~printer:string_of_int 11 @@ int_common p5 10 11;
  assert_equal ~printer:string_of_int 11 @@ int_common p5 11 11

let public_int_common_2 ctxt =
  let q0 = empty_int_tree in
  let q1 = (int_insert 3 (int_insert 8 q0)) in
  let q2 = (int_insert 2 (int_insert 6 q1)) in
  let q3 = (int_insert 12 q2) in
  let q4 = (int_insert 16 (int_insert 9 q3)) in

  assert_equal ~printer:string_of_int 3 @@ int_common q4 2 6;
  assert_equal ~printer:string_of_int 12 @@ int_common q4 9 16;
  assert_equal ~printer:string_of_int 8 @@ int_common q4 2 9;
  assert_equal ~printer:string_of_int 8 @@ int_common q4 3 8;
  assert_equal ~printer:string_of_int 8 @@ int_common q4 6 8;
  assert_equal ~printer:string_of_int 8 @@ int_common q4 12 8;
  assert_equal ~printer:string_of_int 8 @@ int_common q4 8 16

let public_ptree_1 ctxt =
  let r0 = empty_ptree Pervasives.compare in
  let r1 = (pinsert 2 (pinsert 1 r0)) in
  let r2 = (pinsert 3 r1) in
  let r3 = (pinsert 5 (pinsert 3 (pinsert 11 r2))) in
  let a = [5;6;8;3;11;7;2;6;5;1]  in
  let x = [5;6;8;3;0] in
  let z = [7;5;6;5;1] in
  let r4a = pinsert_all x r1 in
  let r4b = pinsert_all z r1 in

  let strlen_comp x y = Pervasives.compare (String.length x) (String.length y) in
  let k0 = empty_ptree strlen_comp in
  let k1 = (pinsert "hello" (pinsert "bob" k0)) in
  let k2 = (pinsert "sidney" k1) in
  let k3 = (pinsert "yosemite" (pinsert "ali" (pinsert "alice" k2))) in
  let b = ["hello"; "bob"; "sidney"; "kevin"; "james"; "ali"; "alice"; "xxxxxxxx"] in

  assert_equal ~printer:string_of_bool_list [false;false;false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y r0) a;
  assert_equal ~printer:string_of_bool_list [false;false;false;false;false;false;true;false;false;true] @@ map (fun y -> pmem y r1) a;
  assert_equal ~printer:string_of_bool_list [false;false;false;true;false;false;true;false;false;true] @@ map (fun y -> pmem y r2) a;
  assert_equal ~printer:string_of_bool_list [true;false;false;true;true;false;true;false;true;true] @@ map (fun y -> pmem y r3) a;

  assert_equal ~printer:string_of_bool_list [false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y k0) b;
  assert_equal ~printer:string_of_bool_list [true;true;false;true;true;true;true;false] @@ map (fun y -> pmem y k1) b;
  assert_equal ~printer:string_of_bool_list [true;true;true;true;true;true;true;false] @@ map (fun y -> pmem y k2) b;
  assert_equal ~printer:string_of_bool_list [true;true;true;true;true;true;true;true] @@ map (fun y -> pmem y k3) b;

  assert_equal ~printer:string_of_bool_list [true;true;true;true;true] @@ map (fun y -> pmem y r4a) x;
  assert_equal ~printer:string_of_bool_list [true;true;false;false;false] @@ map (fun y -> pmem y r4b) x;
  assert_equal ~printer:string_of_bool_list [false;true;true;true;true] @@ map (fun y -> pmem y r4a) z;
  assert_equal ~printer:string_of_bool_list [true;true;true;true;true] @@ map (fun y -> pmem y r4b) z

let public_ptree_2 ctxt =
  let q0 = empty_ptree Pervasives.compare in
  let q1 = pinsert 1 (pinsert 2 (pinsert 0 q0)) in
  let q2 = pinsert 5 (pinsert 11 (pinsert (-1) q1)) in
  let q3 = pinsert (-7) (pinsert (-3) (pinsert 9 q2)) in
  let f = (fun x -> x + 10) in
  let g = (fun y -> y * (-1)) in

  assert_equal ~printer:string_of_int_list [] @@ p_as_list q0;
  assert_equal ~printer:string_of_int_list [0;1;2] @@ p_as_list q1;
  assert_equal ~printer:string_of_int_list [-1;0;1;2;5;11] @@ p_as_list q2;
  assert_equal ~printer:string_of_int_list [-7;-3;-1;0;1;2;5;9;11] @@ p_as_list q3;

  assert_equal ~printer:string_of_int_list [] @@ p_as_list (pmap f q0);
  assert_equal ~printer:string_of_int_list [10;11;12] @@ p_as_list (pmap f q1);
  assert_equal ~printer:string_of_int_list [9;10;11;12;15;21] @@ p_as_list (pmap f q2);
  assert_equal ~printer:string_of_int_list [3;7;9;10;11;12;15;19;21] @@ p_as_list (pmap f q3);

  assert_equal ~printer:string_of_int_list [] @@ p_as_list (pmap g q0);
  assert_equal ~printer:string_of_int_list [-2;-1;0] @@ p_as_list (pmap g q1);
  assert_equal ~printer:string_of_int_list [-11;-5;-2;-1;0;1] @@ p_as_list (pmap g q2);
  assert_equal ~printer:string_of_int_list [-11;-9;-5;-2;-1;0;1;3;7] @@ p_as_list (pmap g q3)

let public_var ctxt =
  let t = push_scope (empty_table ()) in
  let t = add_var "x" 3 t in
  let t = add_var "y" 4 t in
  let t = add_var "asdf" 14 t in
  assert_equal 3 (lookup "x" t) ~msg:"public_var (1)";
  assert_equal 4 (lookup "y" t) ~msg:"public_var (2)";
  assert_equal 14 (lookup "asdf" t) ~msg:"public_var (3)";
  assert_raises (Failure ("Variable not found!")) (fun () -> lookup "z" t) ~msg:"public_var (2)"

let public_scopes ctxt =
  let a = push_scope (empty_table ()) in
  let a = add_var "a" 10 a in
  let a = add_var "b" 40 a in
  let b = push_scope a in
  let b = add_var "a" 20 b in
  let b = add_var "c" 30 b in
  let c = pop_scope b in
  assert_equal 10 (lookup "a" c) ~msg:"public_scopes (1)";
  assert_equal 40 (lookup "b" c) ~msg:"public_scopes (2)";
  assert_equal 20 (lookup "a" b) ~msg:"public_scopes (3)";
  assert_equal 30 (lookup "c" b) ~msg:"public_scopes (4)";
  assert_raises (Failure ("Variable not found!")) (fun () -> lookup "c" c) ~msg:"public_scopes (5)"

let suite =
  "public" >::: [
    "public_count_occ" >:: public_count_occ;
    "public_uniq" >:: public_uniq;
    "public_assoc_list" >:: public_assoc_list;
    "public_int_tree" >:: public_int_tree;
    "public_common_1" >:: public_int_common_1;
    "public_common_2" >:: public_int_common_2;
    "public_ptree_1" >:: public_ptree_1;
    "public_ptree_2" >:: public_ptree_2;
    "public_var" >:: public_var;
    "public_scopes" >:: public_scopes
  ]

let _ = run_test_tt_main suite
