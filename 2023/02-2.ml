(* run with: ocaml -I +str str.cma < input.txt; utop:
    #directory "+str";;
    #load  "str.cma";;
*)

let get_number rx input =
    if Str.string_match (Str.regexp rx) input 0 then
        Str.matched_group 1 input |> int_of_string
    else
        0

let parse_set set =
    get_number {|.*\b\([0-9]+\) red|} set,
    get_number {|.*\b\([0-9]+\) green|} set,
    get_number {|.*\b\([0-9]+\) blue|} set

let max_sets (r1, g1, b1) (r2, g2, b2) = (max r1 r2, max g1 g2, max b1 b2)
let power (r, g, b) = r * g * b

let parse_sets sets =
    String.split_on_char ';' sets |>
    List.map parse_set |>
    List.fold_left max_sets (0, 0, 0) |>
    power

let parse_line line = match String.split_on_char ':' line with
    | _ :: sets :: [] -> parse_sets sets
    | _ -> failwith "parse error"

let lines = String.split_on_char '\n' (In_channel.input_all stdin)

let () =
    List.map parse_line lines |>
    List.fold_left (+) 0 |>
    string_of_int |>
    print_endline
