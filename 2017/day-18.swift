// https://adventofcode.com/2017/day/18

import Foundation

func part1(_ ops: [[String]]) {
    var registers: [String: Int] = [:]
    var i = 0
    var freq = 0

    func operand(_ x: String) -> Int {
        if let n = Int(x) {
            return n
        }
        return registers[x] ?? 0
    }

    while (true) {
        let op = ops[i]
        i += 1
        switch op[0] {
        case "add":
            registers[op[1]] = operand(op[1]) + operand(op[2])
        case "jgz":
            if (registers[op[1]] ?? 0) > 0 {
                i = i - 1 + operand(op[2])
            }
        case "mod":
            registers[op[1]] = operand(op[1]) % operand(op[2])
        case "mul":
            registers[op[1]] = operand(op[1]) * operand(op[2])
        case "rcv":
            if (registers[op[1]] ?? 0) != 0 {
                print(freq)
                return
            }
        case "set":
            registers[op[1]] = operand(op[2])
        case "snd":
            freq = registers[op[1]] ?? 0
        default:
            return
        }
    }
}

class Program {
    var registers: [String: Int]
    var queue: [Int] = []
    var ip: Int = 0
    var waiting: Bool = false

    init(_ id: Int) {
        registers = ["p": id]
    }

    func canrun(_ ops: [[String]]) -> Bool {
        return ip < ops.count && (!waiting || (ops[ip][0] == "rcv" && queue.count > 0))
    }

    func operand(_ x: String) -> Int {
        if let n = Int(x) {
            return n
        }
        return registers[x] ?? 0
    }

    func step(_ p: Int, _ ops: [[String]]) -> Int? {
        let op = ops[ip]
        ip += 1
        switch op[0] {
        case "add":
            registers[op[1]] = operand(op[1]) + operand(op[2])
        case "jgz":
            if operand(op[1]) > 0 {
                ip = ip - 1 + operand(op[2])
            }
        case "mod":
            registers[op[1]] = operand(op[1]) % operand(op[2])
        case "mul":
            registers[op[1]] = operand(op[1]) * operand(op[2])
        case "rcv":
            if queue.count > 0 {
                registers[op[1]] = queue.removeFirst()
                waiting = false
            } else {
                waiting = true
                ip = ip - 1
            }
        case "set":
            registers[op[1]] = operand(op[2])
        case "snd":
            return Optional.some(operand(op[1]))
        default:
            break
        }
        return Optional.none
    }
}

func part2(_ ops: [[String]]) {
    let programs = [Program(0), Program(1)]
    var sends = 0
    var p = 0

    while programs[p].ip < ops.count {
        if let v = programs[p].step(p, ops) {
            if p == 1 {
                sends += 1
            }
            programs[1 - p].queue.append(v)
        } else if programs[p].waiting {
            p = 1 - p
            if programs[p].waiting && programs[p].queue.count == 0 {
                break;
            }
        }
    }

    print(sends)
}

func main() throws {
    let input = try String(contentsOfFile: "input-18.txt", encoding: .ascii)
    let ops = input.components(separatedBy: "\n").map { $0.components(separatedBy: " ") }
    part1(ops)
    part2(ops)
}

try? main()
