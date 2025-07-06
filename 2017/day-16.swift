// https://adventofcode.com/2017/day/16

import Foundation

enum Move {
    case spin(Int)
    case exchange(Int, Int)
    case partner(String, String)
}

func parseMove(_ input: String) -> Move? {
    if let spin = input.firstMatch(of: #/^s(\d+)$/#) {
        return Optional.some(.spin(Int(spin.1)!))
    }
    if let exchange = input.firstMatch(of: #/^x(\d+)\/(\d+)$/#) {
        return Optional.some(.exchange(Int(exchange.1)!, Int(exchange.2)!))
    }
    if let partner = input.firstMatch(of: #/^p(\w)\/(\w)$/#) {
        return Optional.some(.partner(String(partner.1), String(partner.2)))
    }
    return Optional.none
}

func part1(_ programs: String, _ moves: [Move]) {
    var ps = Array(programs)
    let n = programs.count
    for move in moves {
        switch move {
        case .spin(let size):
            let i = n - size
            ps = Array(ps[i..<n]) + Array(ps[0..<i])
        case .exchange(let i, let j):
            ps.swapAt(i, j)
        case .partner(let x, let y):
            ps.swapAt(ps.firstIndex(of: String.Element(x))!, ps.firstIndex(of: String.Element(y))!)
        }
    }
    print(String(ps))
}

func part2(_ programs: String, _ moves: [Move]) {
    var ps = Array(programs)
    let n = programs.count
    var results: [String: Int] = [:]
    for k in 0...1_000_000_000 {
        let key = String(ps)
        if let _ = results[key] {
            let index = 1_000_000_000 % results.count
            print(results.first(where: { $0.value == index })!.key)
            return
        }
        results[key] = k
        for move in moves {
            switch move {
            case .spin(let size):
                let i = n - size
                ps = Array(ps[i..<n]) + Array(ps[0..<i])
            case .exchange(let i, let j):
                ps.swapAt(i, j)
            case .partner(let x, let y):
                ps.swapAt(ps.firstIndex(of: String.Element(x))!, ps.firstIndex(of: String.Element(y))!)
            }
        }
    }
}

func main() throws {
    let input = try String(contentsOfFile: "input-16.txt", encoding: .ascii)
    let moves = input.components(separatedBy: ",").map { parseMove($0)! }
    let programs = "abcdefghijklmnop"
    part1(programs, moves)
    part2(programs, moves)
}

try? main()
