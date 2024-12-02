import pathlib
import sys

def pairwise(iterable):
    iterator = iter(iterable)
    a = next(iterator, None)
    for b in iterator:
        yield a, b
        a = b

def safe(x, y):
    delta = x - y
    return delta >= 1 and delta <= 3

def parse(puzzle_input):
    return [[int(x) for x in line.split()] for line in puzzle_input.split("\n")]

def dampen(levels):
    for i in range(len(levels)):
        ls = levels[:]
        del ls[i]
        if all(safe(x, y) for x, y in pairwise(ls)) or all(safe(y, x) for x, y in pairwise(ls)):
            return True
    return False

def part1(data):
    return sum([
        1 for levels in data
        if all(safe(x, y) for x, y in pairwise(levels)) or all(safe(y, x) for x, y in pairwise(levels))
    ])

def part2(data):
    return sum([1 for levels in data if dampen(levels)])

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
