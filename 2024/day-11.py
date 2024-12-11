import math
import pathlib
import sys

def parse(puzzle_input):
    xs = {}
    for n in puzzle_input.split():
        n = int(n)
        xs[n] = xs.get(n, 0) + 1
    return xs

def blink(stones):
    xs = {}
    for x, n in stones.items():
        if x == 0:
            xs[1] = xs.get(1, 0) + n
        else:
            m = math.ceil(math.log(x + 1, 10))
            if m % 2 == 0:
                p = 10 ** (m / 2)
                u, v = int(x // p), int(x % p)
                xs[u] = xs.get(u, 0) + n
                xs[v] = xs.get(v, 0) + n
            else:
                x *= 2024
                xs[x] = xs.get(x, 0) + n
    return xs

def part1(data):
    for _ in range(25):
        data = blink(data)
    return sum(data.values())

def part2(data):
    for _ in range(75):
        data = blink(data)
    return sum(data.values())

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
