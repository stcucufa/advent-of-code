import Foundation

func part1(_ cells: [[Int]]) {
    print(cells.reduce(0, { z, row in z + row.max()! - row.min()! }))
}

func part2(_ cells: [[Int]]) {
    func divisors(_ row: [Int]) -> Int {
        for x in row {
            for y in row {
                if x != y && x % y == 0 {
                    return x > y ? x / y : y / x;
                }
            }
        }
        return 0
    }
    print(cells.reduce(0, { z, row in z + divisors(row) }))
}

func main() throws {
    let input = try String(contentsOfFile: "input-02.txt", encoding: .ascii)
    let cells = input.split(separator: "\n").map { $0.split(separator: "\t").map { Int($0)! } }
    part1(cells)
    part2(cells)
}

try? main()
