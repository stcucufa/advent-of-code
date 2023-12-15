#require "core"

open! Core

let boxes = List.range 0 256 |> List.map ~f:(fun _ -> []) |> Array.of_list

let to_digit c = int_of_char c - int_of_char '0'

let decode input =
    let rec hash h label cs = match cs with
        | ['-'] -> String.of_list label, h, 0
        | '='::d::[] -> String.of_list label, h, to_digit d
        | c::cs -> hash (((h + int_of_char c) * 17) % 256) (label @ [c]) cs
        | _ -> raise Exit
    in hash 0 [] (String.to_list input)

let rec remove_lens label bs = match bs with
    | [] -> []
    | (l, f)::bs -> if String.equal label l then bs else (l, f) :: (remove_lens label bs)

let rec add_lens label f bs = match bs with
    | [] -> [label, f]
    | (l, g)::bs -> if String.equal label l then (label, f) :: bs else (l, g) :: (add_lens label f bs)

let sort_lens input = let label, i, focal_length = decode input in
    boxes.(i) <- match focal_length with
        | 0 -> remove_lens label boxes.(i)
        | f -> add_lens label f boxes.(i)

let result = In_channel.create "input-15.txt"
    |> In_channel.input_all
    |> String.split ~on:','
    |> List.iter ~f:sort_lens;
    Array.mapi ~f:(fun i bs ->
        List.mapi ~f:(fun j p -> (i + 1) * (j + 1) * snd p) bs
        |> List.fold ~init:0 ~f:(+)
    ) boxes
    |> Array.fold ~init:0 ~f:(+)
