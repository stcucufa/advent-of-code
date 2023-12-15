#require "core"

open! Core

let hash input = String.to_list input
    |> List.fold ~init:0 ~f:(fun h c -> ((h + int_of_char c) * 17) % 256)

let result = In_channel.create "input-15.txt"
    |> In_channel.input_all
    |> String.split ~on:','
    |> List.map ~f:hash
    |> List.fold ~init:0 ~f:(+)
