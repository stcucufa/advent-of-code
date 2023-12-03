#directory "+str"
#load "str.cma"
#require "core"

open! Core

let search_opt rx input i =
    try Some (Str.search_forward rx input i) with
        Not_found -> None

let unwrap_part x = match x with Some(p, i, j) -> (int_of_string p, i, j)

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

let find_gear_at line p j i = 
    if i >= 0 && i < (String.length line) && (phys_equal (String.get line i) '*') then
        Some(p, i, j)
    else
        None

let find_gear_in_range lines p j is =
    if j >= 0 && j < (Array.length lines) then
        match List.map ~f:(find_gear_at lines.(j) p j) is |> List.filter ~f:is_some with
            | [x] -> x
            | _ -> None
    else
        None

let find_gear lines (p, i, j, n) =
    let left = find_gear_at lines.(j) p j (i - 1) in
    if is_some left then left else
        let right = find_gear_at lines.(j) p j (i + n) in
        if is_some right then right else
            let top = find_gear_in_range lines p (j - 1) (List.range (i - 1) (i + n + 1)) in
            if is_some top then top else
            find_gear_in_range lines p (j + 1) (List.range (i - 1) (i + n + 1))

let match_gears parts =
    let rec f z parts = match parts with
        | [] -> z
        | [_] -> z
        | (p, i, j) :: ps -> match List.find ~f:(fun (_, ii, jj) -> ii = i && jj = j) ps with
            | Some (q, _, _) -> f (z + (p * q)) ps
            | None -> f z ps
    in f 0 parts

let input_lines = String.split_lines (In_channel.input_all In_channel.stdin) |> Array.of_list

(*let input_lines = String.split_lines "467..114..\n...*......\n..35..633.\n......#...\n617*......\n.....+.58.\n..592.....\n......755.\n...$.*....\n.664.598.." |> Array.of_list*)

let total = map_with_index input_lines find_numbers
        |> List.concat
        |> List.map ~f:(find_gear input_lines)
        |> List.filter ~f:is_some
        |> List.map ~f:unwrap_part
        |> match_gears
