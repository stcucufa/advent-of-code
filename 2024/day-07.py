import pathlib
import sys

def parse_line(line):
    z, xs = line.split(": ")
    return [int(z), [int(x) for x in xs.split()]]

def parse(puzzle_input):
    return [parse_line(line) for line in puzzle_input.split("\n")]

def valid_input(z, xs):
    if len(xs) == 1:
        return z == xs[0]
    x, y, *rest = xs
    return x < z and valid_input(z, [x + y, *rest]) or valid_input(z, [x * y, *rest])

def valid_input_concat(z, xs):
    if len(xs) == 1:
        return z == xs[0]
    x, y, *rest = xs
    return x < z and valid_input_concat(z, [x + y, *rest]) or valid_input_concat(z, [x * y, *rest]) or \
        valid_input_concat(z, [int(str(x) + str(y)), *rest])

def part1(data):
    return sum(z for z, xs in data if valid_input(z, xs))

def part2(data):
    return sum(z for z, xs in data if valid_input_concat(z, xs))

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
