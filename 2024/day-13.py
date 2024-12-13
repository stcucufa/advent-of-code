import pathlib
import re
import sys

def parse(puzzle_input):
    return [[int(n) for n in re.findall(r"\d+", machine)] for machine in puzzle_input.split("\n\n")]

def count_tokens(m, offset):
    xa, ya, xb, yb, xt, yt = m
    xt += offset
    yt += offset
    b = (xa * yt - ya * xt) / (xa * yb - ya * xb)
    a = (xt - b * xb) / xa
    if a == int(a) and b == int(b):
        return int(3 * a + b)
    return 0

def part1(data):
    return sum(count_tokens(m, 0) for m in data)

def part2(data):
    return sum(count_tokens(m, 10000000000000) for m in data)

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
