(* run with: ocaml -I +str str.cma < input.txt; utop:
    #directory "+str";;
    #load  "str.cma";;
*)

let digit c = Char.code c - Char.code '0';;

let digitize s = match s with
    | "one" -> "1"
    | "two" -> "2"
    | "three" -> "3"
    | "four" -> "4"
    | "five" -> "5"
    | "six" -> "6"
    | "seven" -> "7"
    | "eight" -> "8"
    | "nine" -> "9"
    | d -> d;;

let search_opt rx input i =
    try Some (Str.search_forward rx input i) with
        Not_found -> None;;

let digits_string input =
    let rx = Str.regexp "one\\|two\\|three\\|four\\|five\\|six\\|seven\\|eight\\|nine\\|[1-9]" in
    let n = String.length input in
    let rec digits i result =
        if i >= n then
            result
        else
            match search_opt rx input i with
                | Some j -> let m = Str.matched_string input in
                       (* digits (j + (String.length m)) (result ^ (digitize m)) *)
                       digits (j + 1) (result ^ (digitize m))
                | None -> result
    in digits 0 "";;

let calibration_value input =
    let digits = digits_string input in
    if digits = "" then
        0
    else
        10 * digit (String.get digits 0) + digit (String.get digits (String.length digits - 1));;

let lines = String.split_on_char '\n' (In_channel.input_all stdin)
let () = print_endline (string_of_int (List.fold_left (+) 0 (List.map calibration_value lines)))
