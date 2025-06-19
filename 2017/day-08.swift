// https://adventofcode.com/2017/day/8
// Cf. day-05.swift

import Foundation

let Rx = #/^(\w+) (inc|dec) (-?\d+) if (\w+) ([<>=!]+) (-?\d+)/#

func compare(_ op: Substring, _ x: Int, _ y: Int) -> Bool {
    switch op {
        case ">=": return x >= y
        case "<=": return x <= y
        case ">": return x > y
        case "<": return x < y
        case "==": return x == y
        default: return x != y
    }
}

func part1(_ instructions: [(Substring, Substring, Int, Substring, Substring, Int)]) {
    var registers = Dictionary<Substring, Int>()
    for (a, op, x, b, cmp, y) in instructions {
        if compare(cmp, registers[b] ?? 0, y) {
            _ = registers.updateValue((registers[a] ?? 0) + x * (op == "inc" ? 1 : -1), forKey: a)
        }
    }
    print(registers.values.max()!)
}

func part2(_ instructions: [(Substring, Substring, Int, Substring, Substring, Int)]) {
    var registers = Dictionary<Substring, Int>()
    var m = 0
    for (a, op, x, b, cmp, y) in instructions {
        if compare(cmp, registers[b] ?? 0, y) {
            _ = registers.updateValue((registers[a] ?? 0) + x * (op == "inc" ? 1 : -1), forKey: a)
        }
        m = max(m, registers.values.max() ?? 0)
    }
    print(m)
}

func main() throws {
    let input = try String(contentsOfFile: "input-08.txt", encoding: .ascii)
    let instructions = input.components(separatedBy: "\n").map {
        let match = $0.firstMatch(of: Rx)!
        return (match.1, match.2, Int(match.3)!, match.4, match.5, Int(match.6)!)
    }
    part1(instructions)
    part2(instructions)
}

try? main()
