#require "core"

open! Core

let map_pair f g p = fst p |> f, snd p |> g

let to_pair list = match list with
    | x :: y :: [] -> x, y
    | _ -> failwith "not a double"

let unfold_cs cs = List.map ~f:(fun _ -> '?' :: cs) (List.range 0 5) |> List.join |> List.tl_exn
let unfold_ks ks = List.map ~f:(fun _ -> ks) (List.range 0 5) |> List.join

let count_arrangements p =
    let rec count n p = match p with
        | [], [] -> n + 1
        | ['#'], [1] -> n + 1
        | '?'::cs, ks -> (count n ('.'::cs, ks)) + (count n ('#'::cs, ks))
        | '#'::'#'::cs, 1::ks -> 0
        | '#'::_::cs, 1::ks -> count n (cs, ks)
        | '#'::'.'::cs, m::ks -> 0
        | '#'::_::cs, m::ks -> count n ('#'::cs, (m - 1)::ks)
        | '.'::cs, ks -> count n (cs, ks)
        | _, _ -> 0
    in map_pair unfold_cs unfold_ks p |> count 0

let arrangements line =
    String.split ~on:' ' line
    |> to_pair
    |> map_pair String.to_list (fun counts -> String.split ~on:',' counts |> List.map ~f:int_of_string)
    |> count_arrangements

let result = In_channel.create "test-input-12-1.txt"
    |> In_channel.input_lines
    |> List.map ~f:arrangements
    |> List.fold ~init:0 ~f:(+)
