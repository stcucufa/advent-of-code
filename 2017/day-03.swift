import Foundation

func xy2index(_ xy: (Int, Int)) -> Int {
    let (x, y) = xy
    let r = max(abs(x), abs(y))
    var index = Int(pow(Double(2 * r + 1), 2))
    if y == r {
        return index - r + x
    }
    index -= 2 * r
    if x == -r {
        return index - r + y
    }
    index -= 2 * r
    if y == -r {
        return index - r - x
    }
    return index - 3 * r - y
}

func index2xy(_ index: Int) -> (Int, Int) {
    let r = Int(floor(ceil(sqrt(Double(index))) / 2))
    let m = Int(pow(Double(2 * r + 1), 2))
    var d = m - index
    if d < 2 * r {
        return (r - d, r)
    }
    d -= 2 * r
    if d < 2 * r {
        return (-r, r - d)
    }
    d -= 2 * r
    if d < 2 * r {
        return (d - r, -r)
    }
    d -= 2 * r
    return (r, d - r)
}

func part1(_ input: Int) {
    let (x, y) = index2xy(input)
    print(abs(x) + abs(y))
}

func part2(_ input: Int) {
    var spiral = [0, 1]
    var i = 2
    while spiral[i - 1] < input {
        let (x, y) = index2xy(i)
        var k = 0
        var j = xy2index((x - 1, y - 1))
        k += j < spiral.count ? spiral[j] : 0
        j = xy2index((x, y - 1))
        k += j < spiral.count ? spiral[j] : 0
        j = xy2index((x + 1, y - 1))
        k += j < spiral.count ? spiral[j] : 0
        j = xy2index((x - 1, y))
        k += j < spiral.count ? spiral[j] : 0
        j = xy2index((x + 1, y))
        k += j < spiral.count ? spiral[j] : 0
        j = xy2index((x - 1, y + 1))
        k += j < spiral.count ? spiral[j] : 0
        j = xy2index((x, y + 1))
        k += j < spiral.count ? spiral[j] : 0
        j = xy2index((x + 1, y + 1))
        k += j < spiral.count ? spiral[j] : 0
        spiral.append(k)
        i += 1
    }
    print(spiral[i - 1])
}

func main() {
    let input = 325489
    part1(input)
    part2(input)
}

main()
