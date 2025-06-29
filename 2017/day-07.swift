import Foundation

func part1(_ discs: Dictionary<String, (Int, [String])>) -> String {
    var bottom = Set(discs.keys)
    for (_, above) in discs.values {
        for d in above {
            bottom.remove(d)
        }
    }
    let b = bottom.count == 1 ? bottom.first ?? "?!" : "!?"
    print(b)
    return b
}

func part2(_ bottom: String, _ discs: Dictionary<String, (Int, [String])>) {
    var weights = Dictionary<String, Int>()
    func weight(_ disc: String) -> Int {
        if !weights.keys.contains(disc) {
            let (w, above) = discs[disc]!
            _ = weights.updateValue(above.reduce(w, { z, d in z + weight(d) }), forKey: disc)
        }
        return weights[disc]!
    }
    var d = bottom
    var Δ = 0
    while true {
        let (_, above) = discs[d]!
        let ws = Dictionary(grouping: above, by: weight)
        if ws.count < 2 {
            print(discs[d]!.0 + Δ)
            return
        }
        let outside = ws.keys.min { a, b in ws[a]!.count < ws[b]!.count }!
        let inside = ws.keys.max { a, b in ws[a]!.count < ws[b]!.count }!
        Δ = inside - outside
        d = ws[outside]!.first!
    }
}

func main() throws {
    let input = try String(contentsOfFile: "input-07.txt", encoding: .ascii)
    let rx = #/^(\w+) \((\d+)\)( -> (.+))?/#
    let discs = Dictionary(uniqueKeysWithValues: input.components(separatedBy: "\n").map {
        let match = $0.firstMatch(of: rx)!
        return (String(match.1), (Int(match.2)!, match.4?.components(separatedBy: ", ") ?? []))
    })
    let bottom = part1(discs)
    part2(bottom, discs)
}

try? main()
