// https://adventofcode.com/2017/day/15

import Foundation

func part1(_ a: Int, _ b: Int) {
    var matches = 0
    var (a, b) = (a, b)
    for _ in 1...40_000_000 {
        a = (a * 16807) % 2147483647
        b = (b * 48271) % 2147483647
        if (a & 0xffff == b & 0xffff) {
            matches += 1
        }
    }
    print(matches)
}

func part2(_ a: Int, _ b: Int) {
    var matches = 0
    var (a, b) = (a, b)
    for _ in 1...5_000_000 {
        repeat {
            a = (a * 16807) % 2147483647
        } while a % 4 != 0
        repeat {
            b = (b * 48271) % 2147483647
        } while b % 8 != 0
        if (a & 0xffff == b & 0xffff) {
            matches += 1
        }
    }
    print(matches)
}

func main() throws {
    let input = try String(contentsOfFile: "input-15.txt", encoding: .ascii)
    let generators = input.matches(of: #/\d+/#).map { Int($0.0)! }
    let (a, b) = (generators[0], generators[1])
    // let (a, b) = (65, 8921)
    part1(a, b)
    part2(a, b)
}

try? main()
