import Foundation

func part1(_ input: [Int]) {
    var jumps = input
    var i = 0
    var k = 0
    while i < jumps.count {
        jumps[i] += 1
        i += jumps[i] - 1
        k += 1
    }
    print(k)
}

func part2(_ input: [Int]) {
    var jumps = input
    var i = 0
    var k = 0
    while i < jumps.count {
        let j = jumps[i]
        jumps[i] += j > 2 ? -1 : 1
        i += j
        k += 1
    }
    print(k)
}

func main() throws {
    let input = try String(contentsOfFile: "input-05.txt", encoding: .ascii)
    let jumps = input.components(separatedBy: "\n").map { Int($0)! }
    part1(jumps)
    part2(jumps)
}

try? main()
