#require "core"

open! Core

let tokenize input =
    String.split ~on:' ' input
    |> List.filter ~f:(fun x -> not (String.is_empty x))

let to_double list = match list with
    | x :: y :: [] -> x, y
    | _ -> failwith "not a double"

let race time distance =
    let delta = time *. time -. 4. *. distance |> sqrt in
    let x0 = (time -. delta) /. 2. in
    let x1 = (time +. delta) /. 2. in
    1 + (int_of_float x1 - int_of_float (ceil x0))

let input_lines = In_channel.create "input-06.txt" |> In_channel.input_lines

let time, distance = List.map ~f:(
    fun line -> tokenize line |> List.tl_exn |> List.fold ~init:"" ~f:(^) |> float_of_string
) input_lines |> to_double

let result = race time distance
