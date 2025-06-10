import Foundation

func part1(_ digits: [Int]) {
    let n = digits.count
    var sum = 0
    for (i, digit) in digits.enumerated() {
        if digit == digits[(i + 1) % n] {
            sum += digit
        }
    }
    print(sum)
}

func part2(_ digits: [Int]) {
    let n = digits.count
    var sum = 0
    for (i, digit) in digits.enumerated() {
        if digit == digits[(i + n / 2) % n] {
            sum += digit
        }
    }
    print(sum)
}

func main() throws {
    let input = try String(contentsOfFile: "input-01.txt", encoding: .ascii)
    let digits = Array(input).map { Int(String($0))! }
    part1(digits)
    part2(digits)
}

try? main()
