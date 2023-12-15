#require "core"

open! Core

let tokenize input =
    String.split ~on:' ' input
    |> List.filter ~f:(fun x -> not (String.is_empty x))

let rec map1 f z xs = match xs with
    | [] -> []
    | y :: ys -> (f z y) :: (map1 f y ys)

let diff = Fn.flip (-)

let rec reduce xs = match xs with
    | [] -> 0
    | y :: ys -> if List.for_all ~f:Fn.id (map1 (=) y ys) then y else
        y - (map1 diff y ys |> reduce)

let result = In_channel.create "input-09.txt"
    |> In_channel.input_lines
    |> List.map ~f:(fun line -> tokenize line |> List.map ~f:int_of_string |> reduce)
    |> List.fold ~init:0 ~f:(+)
