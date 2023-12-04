#require "core"

open! Core

let split_in_two sep input =
    match String.split ~on:sep input with
        left :: right :: [] -> (left, right)

let tokenize input =
    String.split ~on:' ' input
    |> List.filter ~f:(fun x -> not (String.is_empty x))

let get_card_number card =
    match tokenize card with
        _ :: number :: [] -> int_of_string number

let parse_card line =
    let (card_number, numbers) = split_in_two ':' line in
    let n = get_card_number card_number in
    let (winning, card) = split_in_two '|' numbers in
    let to_set input = tokenize input |> Set.of_list (module String) in
    let m = Set.inter (to_set winning) (to_set card) |> Set.length in
    (List.range n (n + m + 1))

let get_copies copies card = 
    let rec make_copies n is =
        match is with
        | [] -> copies
        | i :: is -> copies.(i - 1) <- copies.(i - 1) + n; make_copies n is
    in match card with
        i :: is -> make_copies copies.(i - 1) is

let input = In_channel.create "input-04.txt"
let input_lines = In_channel.input_lines input

let cards = List.map ~f:parse_card input_lines |> Array.of_list

let copies = Array.fold ~init:(Array.map ~f:(fun _ -> 1) cards) ~f:get_copies cards

let score = Array.fold ~init:0 ~f:(+) copies
