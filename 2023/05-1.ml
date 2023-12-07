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

let parse_seeds input =
    let (hd, _) = uncons input in
    let (_, numbers) = String.split ~on:' ' hd |> uncons in
    List.map ~f:int_of_string numbers

let parse_map input =
    let (_, entries) = uncons input in
    let parse_line line =
        match String.split ~on:' ' line |> List.map ~f:int_of_string with
        x :: y :: z :: [] -> (x, y, z) in
    List.map ~f:parse_line entries

let rec apply_map n map = match map with
    | [] -> n
    | (dest, source, length) :: map ->
            if n >= source && n < (source + length) then dest + n - source else apply_map n map

let apply_maps maps n = List.fold ~init:n ~f:(apply_map) maps

let input_lines = In_channel.create "input-05.txt" |> In_channel.input_lines
let (seeds_strings, maps_strings) = paragraphs input_lines |> uncons
let seeds = parse_seeds seeds_strings
let maps = List.map ~f:parse_map maps_strings
let locations = List.map ~f:(apply_maps maps) seeds
let lowest = fold1 min locations
