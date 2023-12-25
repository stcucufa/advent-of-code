#require "core"

open! Core

let tokenize input =
    String.split ~on:' ' input
    |> List.filter ~f:(fun x -> not (String.is_empty x))

let to_pair list = match list with
    | x :: y :: [] -> x, y
    | _ -> failwith "not a double"

let components edges =
    let union sets edge =
        let rec merge sets e = match sets with
            | [] -> [e]
            | s :: sets -> if Set.length (Set.inter e s) = 0
                then s :: (merge sets e)
                else merge sets (Set.union e s)
        in merge sets (Set.of_list (module String) [fst edge; snd edge])
    in List.fold ~init:[] ~f:union edges

let build_graph lines =
    let add_edge u edges v = (u, v) :: edges in
    let add_edges edges line =
        let p = String.split ~on:':' line |> to_pair in
        let u = fst p in
        tokenize (snd p) |> List.fold ~init:edges ~f:(add_edge u) in
    List.fold ~init:[] ~f:add_edges lines

(* Fisher-Yates shuffle from https://en.wikipedia.org/wiki/Fisher–Yates_shuffle *)
let shuffle edges =
    let array = Array.of_list edges in
    let n = Array.length array in
    for i = 0 to n - 2 do
        let j = if i = 0 then 0 else Random.int i in
        let a = array.(j) in
        array.(j) <- array.(i);
        array.(i) <- a
    done;
    array

let rec check_components edges =
    let ks = shuffle edges
        |> Array.filteri ~f:(fun i _ -> i > 2)
        |> Array.to_list
        |> components in
    match List.length ks with
        | 2 -> List.map ~f:(Set.length) ks |> List.fold ~init:1 ~f:( * )
        | _ -> check_components edges

let result = In_channel.create "test-input-25.txt"
    |> In_channel.input_lines
    |> build_graph
    |> check_components
