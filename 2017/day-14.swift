// https://adventofcode.com/2017/day/14 

import Foundation

// Knot hash from day 10
func knotHash(_ input: String, _ N: Int = 256) -> [Int] {
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
            byte ^= knots[16 * i + j]
        }
        bytes.append(byte)
    }
    return bytes
}

func part1(_ hashes: [[Int]]) {
    print(hashes.reduce(0, { z, bytes in z + bytes.reduce(0, { $0 + $1.nonzeroBitCount }) }))
}

func part2(_ hashes: [[Int]]) {
    var uf = Dictionary<Int, Int>()

    func root(_ x: Int) -> Int {
        let y = uf[x]!
        return x == y ? x : root(y)
    }

    func merge(_ i: Int, _ j: Int, _ shift: Int, _ byte: Int) {
        let mask = 0b1000_0000 >> shift
        if mask & byte != 0 {
            let k = 128 * j + 8 * i + shift
            uf[k] = k
            if i > 0 || shift > 0 {
                if let kk = uf[k - 1] {
                    uf[root(kk)] = k
                }
            }
            if let kk = uf[k - 128] {
                uf[root(kk)] = k
            }
        }
    }

    for (j, bytes) in hashes.enumerated() {
        for (i, byte) in bytes.enumerated() {
            for shift in 0..<8 {
                merge(i, j, shift, byte)
            }
        }
    }

    var regions = Set<Int>()
    for k in uf.keys {
        regions.insert(root(k))
    }
    print(regions.count)
}

func main() {
    let input = "nbysizxe"
    // let input = "flqrgnkx"
    let hashes = (0..<128).map { knotHash(input + "-" + String($0)) }
    part1(hashes)
    part2(hashes)
}

main()
