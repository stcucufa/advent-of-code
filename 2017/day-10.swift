// https://adventofcode.com/2017/day/10

import Foundation

func part1(_ input: String, _ N: Int) {
    let lengths = input.components(separatedBy: ",").map { Int($0)! }
    var knots = Array(0..<N)
    var i = 0
    var k = 0
    for n in lengths {
        for j in 0..<Int(n / 2) {
            let i1 = (i + j) % N
            let i2 = (i + n - 1 - j) % N
            let t = knots[i1]
            knots[i1] = knots[i2]
            knots[i2] = t
        }
        i = (i + n + k) % N
        k += 1
    }
    print(knots[0] * knots[1])
}

func part2(_ input: String, _ N: Int) {
    var lengths = input.map { Int($0.asciiValue!) }
    lengths.append(contentsOf: [17, 31, 73, 47, 23])
    var knots = Array(0..<N)
    var i = 0
    var k = 0
    for _ in 1...64 {
        for n in lengths {
            for j in 0..<Int(n / 2) {
                let i1 = (i + j) % N
                let i2 = (i + n - 1 - j) % N
                let t = knots[i1]
                knots[i1] = knots[i2]
                knots[i2] = t
            }
            i = (i + n + k) % N
            k += 1
        }
    }
    var bytes: [Int] = []
    for i in 0..<16 {
        var byte = knots[16 * i]
        for j in 1..<16 {
            byte = byte ^ knots[16 * i + j]
        }
        bytes.append(byte)
    }
    print(bytes.map { String(format: "%02hhx", $0) }.joined(separator: ""))
}

func main() throws {
    let input = try String(contentsOfFile: "input-10.txt", encoding: .ascii)
    let N = 256
    part1(input, N)
    part2(input, N)
}

try? main()
