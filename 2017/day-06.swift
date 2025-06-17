import Foundation

func part1(_ input: [Int]) {
    var blocks = input
    var seen = Set<[Int]>()
    var i = 1
    while true {
        let m = blocks.enumerated().max { a, b in a.element < b.element }!
        blocks[m.offset] = 0
        for j in 1...m.element {
            blocks[(m.offset + j) % blocks.count] += 1
        }
        let (unique, _) = seen.insert(blocks)
        if !unique {
            print(i)
            return
        }
        i += 1
    }
}

func part2(_ input: [Int]) {
    var blocks = input
    var seen = Dictionary<[Int], Int>()
    var i = 1
    while true {
        let m = blocks.enumerated().max { a, b in a.element < b.element }!
        blocks[m.offset] = 0
        for j in 1...m.element {
            blocks[(m.offset + j) % blocks.count] += 1
        }
        if let start = seen.updateValue(i, forKey: blocks) {
            print(i - start)
            return
        }
        i += 1
    }
}

func main() throws {
    let input = try String(contentsOfFile: "input-06.txt", encoding: .ascii)
    let blocks = input.components(separatedBy: "\t").map { Int($0)! }
    part1(blocks)
    part2(blocks)
}

try? main()
