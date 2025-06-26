// https://adventofcode.com/2017/day/12

import Foundation

func main() throws {
    let input = try String(contentsOfFile: "input-12.txt", encoding: .ascii)
    let lines = input.components(separatedBy: "\n").map { $0.components(separatedBy: " <-> ") }
    var uf = Dictionary<String, String>()
    func root(_ x: String) -> String {
        let y = uf[x]!
        return x == y ? x : root(y)
    }
    for line in lines {
        let x = line[0]
        uf[x] = x
    }
    for line in lines {
        let id = line[0]
        for other in line[1].components(separatedBy: ", ") {
            let x = root(id)
            let y = root(other)
            uf[x] = y
        }
    }

    let zero = root("0")
    var group = Set<String>()
    var groups = Set<String>()
    for line in lines {
        let x = line[0]
        let r = root(x)
        groups.insert(r)
        if r == zero {
            group.insert(x)
        }
    }
    print(group.count)
    print(groups.count)
}
try? main()
