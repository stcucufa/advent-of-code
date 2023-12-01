(* run with: ocaml -I +str str.cma < input.txt; utop:
    #directory "+str";;
    #load  "str.cma";;
*)

let digit c = Char.code c - Char.code '0'

let calibration_value input =
    let digits = Str.global_replace (Str.regexp {|[^0-9]|}) "" input in
    if digits = "" then
        0
    else
        10 * digit (String.get digits 0) + digit (String.get digits (String.length digits - 1))

let lines = String.split_on_char '\n' (In_channel.input_all stdin)
let () = print_endline (string_of_int (List.fold_left (+) 0 (List.map calibration_value lines)))
