import pathlib
import sys

def unzip(pairs):
    xs = []
    ys = []
    for x, y in pairs:
        xs.append(x)
        ys.append(y)
    return xs, ys

def parse(puzzle_input):
    return unzip([[int(n) for n in line.split()] for line in puzzle_input.split("\n")])

def part1(data):
    xs, ys = data
    xs.sort()
    ys.sort()
    return sum(abs(x - y) for x, y in zip(xs, ys))

def part2(data):
    xs, ys = data
    return sum(sum(y for y in ys if y == x) for x in xs)

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
