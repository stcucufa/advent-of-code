#require "core"

open! Core

let split_in_two sep input =
    match String.split ~on:sep input with
        left :: right :: [] -> (left, right)

let parse_card line =
    let (_, numbers) = split_in_two ':' line in
    let (winning, card) = split_in_two '|' numbers in
    let tokenize input =
        String.split ~on:' ' input
        |> List.filter ~f:(fun x -> not (String.is_empty x))
        |> Set.of_list (module String) in
    let n = Set.inter (tokenize winning) (tokenize card) |> Set.length in
    if n = 0 then
        0
    else
        int_of_float (2. ** float_of_int (n - 1))

let input = In_channel.create "input-04.txt"
let input_lines = In_channel.input_lines input

let cards = List.map ~f:parse_card input_lines |> List.fold ~init:0 ~f:(+)
