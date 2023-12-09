#require "core"

open! Core

module Graph = Map.Make (String)

let tokenize input =
    String.split ~on:' ' input
    |> List.filter ~f:(fun x -> not (String.is_empty x))

let to_pair list = match list with
    | x :: y :: [] -> x, y
    | _ -> failwith "not a double"

let map_pair f g p = fst p |> f, snd p |> g

let split_head xs = match xs with
    | hd :: _ :: tl -> hd, tl
    | _ -> failwith "not enough content"

let ends_with c string = String.length string - 1 |> String.get string |> phys_equal c

let parse_node input =
    tokenize input
    |> split_head
    |> map_pair Fn.id (fun p -> List.map ~f:(
            String.strip ~drop:(fun c -> phys_equal c '(' || phys_equal c ')' || phys_equal c ',')
        ) p |> to_pair)

let follow dirs graph pair = match pair with origin, dest ->
    let rec follow_step dirs graph k current =
        if equal_string current dest then k else
            match dirs with
            | [] -> failwith "no directions"
            | d :: ds -> let l, r = Map.find_exn graph current in
                follow_step (ds @ [d]) graph (k + 1) (match d with 'L' -> l | 'R' -> r | _ -> failwith "?")
    in follow_step dirs graph 0 origin

let follow_all instructions =
    match instructions with
    dirs, graph -> let keys = Map.keys graph in
        (*List.map ~f:(follow dirs graph)*) (List.cartesian_product
            (List.filter ~f:(ends_with 'A') keys) (List.filter ~f:(ends_with 'Z') keys))

let result = In_channel.create "test-input-08-3.txt"
    |> In_channel.input_lines
    |> split_head
    |> map_pair String.to_list (fun nodes -> List.map ~f:(parse_node) nodes |> Graph.of_alist_exn)
    |> follow_all
