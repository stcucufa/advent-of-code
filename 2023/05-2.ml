#require "core"

open! Core

let fold1 f xs = match xs with init :: list -> List.fold ~init ~f list

let paragraphs lines =
    let add ps p = if List.is_empty p then ps else ps @ [p] in
    let rec group ps p ls = match ls with
    | [] -> add ps p
    | l :: ls -> if String.is_empty l
                then group (add ps p) [] ls
                else group ps (p @ [l]) ls in
    group [] [] lines

let uncons xs = match xs with hd :: tl -> (hd, tl)

let rec pairs xs = match xs with
    | [] -> []
    | x1 :: x2 :: xs -> (x1, x1 + x2 - 1) :: pairs xs

let parse_seeds input =
    let (hd, _) = uncons input in
    let (_, numbers) = String.split ~on:' ' hd |> uncons in
    List.map ~f:int_of_string numbers

let fill_gaps map =
    let rec fill n xs = match xs with
    | [] -> [n, Int.max_value, 0]
    | x :: xs ->
            let x0, x1, _ = x in
            let ys = fill (x1 + 1) xs in
            if x0 = n then x :: ys
            else (n, x0 - 1, 0) :: x :: ys
    in fill 0 map

let parse_map input =
    let (_, entries) = uncons input in
    let parse_line line =
        match String.split ~on:' ' line |> List.map ~f:int_of_string with
        x :: y :: z :: [] -> y, y + z - 1, x - y in
    List.map ~f:parse_line entries
    |> List.sort ~compare:(fun a b -> fst3 a - fst3 b)
    |> fill_gaps

let split_range map range =
    let rec split range map ranges = match map with
    | [] -> ranges @ [range]
    | x :: xs ->
            let r0, r1 = range in
            let x0, x1, x2 = x in
            if r0 > x1 then split range xs ranges
            else if r1 < x1 then ranges @ [r0 + x2, r1 + x2]
            else split (x1 + 1, r1) xs (ranges @ [r0 + x2, x1 + x2])
    in split range map []

let apply_map ranges map = List.map ~f:(split_range map) ranges |> List.concat

let input_lines = In_channel.create "input-05.txt" |> In_channel.input_lines
let (seeds_strings, maps_strings) = paragraphs input_lines |> uncons
let seeds = parse_seeds seeds_strings |> pairs
let maps = List.map ~f:parse_map maps_strings
let locations = List.fold ~init:seeds ~f:(apply_map) maps
let m = List.fold ~init:Int.max_value ~f:(fun z range -> min z (fst range)) locations
