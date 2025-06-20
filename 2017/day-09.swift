// https://adventofcode.com/2017/day/9

import Foundation

func sum(_ xs: [Int]) -> Int {
    return xs.reduce(0, { $0 + $1 })
}

func cleanup(_ input: String) -> String {
    return input.reduce(("", false, false), { z, c in 
        let (out, garbage, escape) = z
        if escape {
            return (out, garbage, false)
        }
        if garbage {
            return (out, c != ">", c == "!")
        }
        if c == "<" {
            return (out, true, false)
        }
        if c == "!" {
            return (out, false, true)
        }
        return (out + String(c), false, false)
    }).0
}

func score(_ input: String) -> Int {
    return input.reduce((0, 1), { z, c in
        let (score, depth) = z
        if c == "{" {
            return (score + depth, depth + 1)
        }
        if c == "}" {
            return (score, depth - 1)
        }
        return z
    }).0
}

func part1(_ lines: [String]) {
    print(sum(lines.map { score(cleanup($0)) }))
}

func part2(_ lines: [String]) {
    print(sum(lines.map {
        $0.reduce(("", false, false), { z, c in 
            let (out, garbage, escape) = z
            if escape {
                return (out, garbage, false)
            }
            if c == "!" {
                return (out, garbage, true)
            }
            if garbage {
                if c == ">" {
                    return (out, false, false)
                }
                return (out + String(c), c != ">", false)
            }
            return (out, c == "<", false)
        }).0.count
    }))
}

func main() throws {
    let input = try String(contentsOfFile: "input-09.txt", encoding: .ascii)
    let lines = input.components(separatedBy: "\n")
    part1(lines)
    part2(lines)
}

try? main()
