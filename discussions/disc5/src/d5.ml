type head_with_count = Head of int 
type tail_with_count = Tail of int
type side_with_count_tuple = head_with_count * tail_with_count 

let flip n =
    let _ = Random.init 0 in (* Do not change the seed. It will not allow us to predict your output and your tests will fail*)
    let rec do_flips res count =
        failwith "unimplemented"
    in
    let flips = do_flips [] n in
        failwith "unimplemented";;

let nth_pos lst n =
    failwith "unimplemented";;
  
