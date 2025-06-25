// https://adventofcode.com/2017/day/11

import Foundation

func distance(_ p: (Int, Int)) -> Int {
    let (x, y) = p
    return abs(x) + abs((abs(x) - abs(y)) / 2)
}

func part1(_ steps: [String]) {
    let directions = ["n": (0, 2), "ne": (1, 1), "se": (1, -1), "s": (0, -2), "sw": (-1, -1), "nw": (-1, 1)]
    print(distance((steps.reduce((0, 0), { z, step in
        let (x, y) = z
        let (dx, dy) = directions[step]!
        return (x + dx, y + dy)
    }))))
}

func part2(_ steps: [String]) {
    let directions = ["n": (0, 2), "ne": (1, 1), "se": (1, -1), "s": (0, -2), "sw": (-1, -1), "nw": (-1, 1)]
    let (_, _, m) = (steps.reduce((0, 0, 0), { z, step in
        let (x, y, m) = z
        let (dx, dy) = directions[step]!
        return (x + dx, y + dy, max(m, distance((x, y))))
    }))
    print(m)
}

func main() throws {
    let input = try String(contentsOfFile: "input-11.txt", encoding: .ascii)
    let steps = input.components(separatedBy: ",")
    part1(steps)
    part2(steps)
}

try? main()
