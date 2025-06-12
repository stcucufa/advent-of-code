import Foundation

func part1(_ passphrases: [String]) {
    func isvalid(_ passphrase: String) -> Bool {
        var words: Set<String> = Set()
        for word in passphrase.components(separatedBy: " ") {
            let (unique, _) = words.insert(word)
            if !unique {
                return false
            }
        }
        return true
    }
    print(passphrases.filter(isvalid).count)
}

func part2(_ passphrases: [String]) {
    func isvalid(_ passphrase: String) -> Bool {
        var words: Set<String> = Set()
        for word in passphrase.components(separatedBy: " ") {
            let (unique, _) = words.insert(String(Array(word).sorted()))
            if !unique {
                return false
            }
        }
        return true
    }
    print(passphrases.filter(isvalid).count)
}

func main() throws {
    let input = try String(contentsOfFile: "input-04.txt", encoding: .ascii)
    let passphrases = input.components(separatedBy: "\n")
    part1(passphrases)
    part2(passphrases)
}

try? main()
