#require "core"

open! Core

let tokenize input =
    String.split ~on:' ' input
    |> List.filter ~f:(fun x -> not (String.is_empty x))

let to_pair list = match list with
    | x :: y :: [] -> x, y
    | _ -> failwith "not a double"

let map_pair f g p = fst p |> f, snd p |> g

let digit c = Char.to_int c - Char.to_int '0';;

let card_value c = match c with
    | 'T' -> 10
    | 'J' -> 11
    | 'Q' -> 12
    | 'K' -> 13
    | 'A' -> 14
    | c -> digit c

let rec compare_values xs ys =
    match xs with
    | [] -> 0
    | x :: xs -> match ys with
        | y :: ys -> if x = y then compare_values xs ys else y - x
        | _ -> failwith "unexpected empty list"

let compare_hands x y =
    let rank_x, cards_x = x in
    let rank_y, cards_y = y in
    let delta_rank = compare_values rank_x rank_y in
    if delta_rank = 0 then compare_values cards_x cards_y else delta_rank

let hand_rank hand =
    let cards = List.range 0 (card_value 'A' + 1) |> List.map ~f:(fun _ -> 0) |> List.to_array in
    let ranks = List.iter ~f:(fun i -> cards.(i) <- cards.(i) + 1) hand; Array.to_list cards
        |> List.filter ~f:(Fn.non (phys_equal 0)) |> List.sort ~compare:(fun a b -> b - a) in
    ranks, hand

let parse_hand hand = String.to_list hand |> List.map ~f:card_value |> hand_rank

let result = In_channel.create "input-07.txt"
    |> In_channel.input_lines
    |> List.map ~f:(fun x -> tokenize x |> to_pair |> map_pair parse_hand int_of_string)
    |> List.sort ~compare:(fun h2 h1 -> compare_hands (fst h1) (fst h2))
    |> List.mapi ~f:(fun i h -> (i + 1) * (snd h))
    |> List.fold ~init:0 ~f:(+)
