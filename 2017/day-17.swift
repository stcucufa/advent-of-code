// https://adventofcode.com/2017/day/17

import Foundation

let N = 343

func part1() {
    var buffer = [0]
    var i = 0
    for n in 1...2017 {
        i = (i + N + 1) % n
        buffer.insert(n, at: i)
    }
    print(buffer[(i + 1) % buffer.count])
}

func part2() {
    var i = 0
    var m = 0
    for n in 1...50_000_000 {
        i = (i + N + 1) % n
        if i == 0 {
            m = n
        }
    }
    print(m)
}

func main() {
    part1()
    part2()
}

main()
