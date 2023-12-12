#require "core"

open! Core

let map_pair f g p = fst p |> f, snd p |> g

let to_pair list = match list with
    | x :: y :: [] -> x, y
    | _ -> failwith "not a double"

let count_arrangements p =
    let rec count p n = match p with
        | [], [] -> n + 1
        | ['#'], [1] -> n + 1
        | '?'::cs, ks -> (count ('.'::cs, ks) n) + (count ('#'::cs, ks) n)
        | '#'::'#'::cs, 1::ks -> 0
        | '#'::_::cs, 1::ks -> count (cs, ks) n
        | '#'::'.'::cs, m::ks -> 0
        | '#'::_::cs, m::ks -> count ('#'::cs, (m - 1)::ks) n
        | '.'::cs, ks -> count (cs, ks) n
        | _, _ -> 0
    in count p 0

let arrangements line =
    String.split ~on:' ' line
    |> to_pair
    |> map_pair String.to_list (fun counts -> String.split ~on:',' counts |> List.map ~f:int_of_string)
    |> count_arrangements

let result = In_channel.create "input-12.txt"
    |> In_channel.input_lines
    |> List.map ~f:arrangements
    |> List.fold ~init:0 ~f:(+)
