#require "core"

open! Core

let tokenize input =
    String.split ~on:' ' input
    |> List.filter ~f:(fun x -> not (String.is_empty x))

let to_double list = match list with
    | x :: y :: [] -> x, y
    | _ -> failwith "not a double"

let race time distance = List.range 0 (time + 1)
    |> List.map ~f:(fun pressed -> (time - pressed) * pressed)
    |> List.filter ~f:((<) distance)
    |> List.length

let input_lines = In_channel.create "input-06.txt" |> In_channel.input_lines

let times, distances = List.map ~f:(
    fun line -> tokenize line |> List.tl_exn |> List.map ~f:int_of_string
) input_lines |> to_double

let result = match List.map2 ~f:race times distances with
    | Ok list -> List.fold ~init:1 ~f:( * ) list
    | _ -> failwith "unequal lengths"
