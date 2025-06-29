// https://adventofcode.com/2017/day/13

import Foundation

func position(inRange n: Int, atTime t: Int) -> Int {
    let m = n - 1
    return m - abs(m - (t % (2 * m)))
}

func part1(_ ranges: Dictionary<Int, Int>, _ layers: Int) {
    var z = 0
    for i in 0...layers {
        if let n = ranges[i] {
            if position(inRange: n, atTime: i) == 0 {
                z += i * n
            }
        }
    }
    print(z)
}

func part2(_ ranges: Dictionary<Int, Int>, _ layers: Int) {
    var delay = 0
    func detected() -> Bool {
        for i in 0...layers {
            if let n = ranges[i] {
                if position(inRange: n, atTime: i + delay) == 0 {
                    return true
                }
            }
        }
        return false
    }
    while true {
        if !detected() {
            print(delay)
            return
        }
        delay += 1
    }
}

func main() throws {
    let input = try String(contentsOfFile: "input-13.txt", encoding: .ascii)
    let ranges = Dictionary(uniqueKeysWithValues: input.components(separatedBy: "\n").map {
        let pair = $0.components(separatedBy: ": ").map { Int($0)! }
        return (pair[0], pair[1])
    })
    let layers = ranges.keys.max()!
    part1(ranges, layers)
    part2(ranges, layers)
}

try? main()
