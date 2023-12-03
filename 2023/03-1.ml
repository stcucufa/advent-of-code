#directory "+str"
#load "str.cma"

#require "core"

open! Core

let search_opt rx input i =
    try Some (Str.search_forward rx input i) with
        Not_found -> None

let map_with_index xs f = List.map ~f:(fun i -> f xs.(i) i) (List.range 0 (Array.length xs))

let find_numbers input k =
    let rx = Str.regexp "[0-9]+" in
    let n = String.length input in
    let rec numbers i result =
        if i >= n then
            result
        else
            match search_opt rx input i with
                | Some j -> let m = Str.matched_string input in
                            let l = String.length m in
                            numbers (j + l) ((m, j, k, l) :: result)
                | None -> result
    in numbers 0 []

let has_symbol_at line i =
    i >= 0 && i < (String.length line) && not (phys_equal (String.get line i) '.')

let has_symbol_in_range lines j is =
    j >= 0 && j < (Array.length lines) && List.exists ~f:(has_symbol_at lines.(j)) is

let is_valid_number lines (_, i, j, n) =
    has_symbol_at lines.(j) (i - 1) ||
    has_symbol_at lines.(j) (i + n) ||
    has_symbol_in_range lines (j - 1) (List.range (i - 1) (i + n + 1)) ||
    has_symbol_in_range lines (j + 1) (List.range (i - 1) (i + n + 1))

let input_lines = String.split_lines (In_channel.input_all In_channel.stdin) |> Array.of_list

(*let input_lines = String.split_lines "467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598.." |> Array.of_list*)

let numbers = map_with_index input_lines find_numbers
                |> List.concat
                |> List.filter ~f:(is_valid_number input_lines)
                |> List.map ~f:(fun (x, _, _, _) -> int_of_string x)
                |> List.fold ~init:0 ~f:(+)
