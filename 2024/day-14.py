import functools
import pathlib
import re
import sys

def parse(puzzle_input):
    return [[int(n) for n in re.findall(r"-?\d+", line)] for line in puzzle_input.split("\n")]

def part1(data):
    if len(data) < 100:
        w, h = 11, 7
    else:
        w, h = 101, 103
    grid = {}
    for x, y, vx, vy in data:
        p = (x, y)
        if not p in grid:
            grid[p] = set()
        grid[p].add((vx, vy))
    for _ in range(100):
        after = {}
        for p, vs in grid.items():
            x, y = p
            for v in vs:
                vx, vy = v
                q = (x + vx) % w, (y + vy) % h
                if not q in after:
                    after[q] = set()
                after[q].add(v)
        grid = after
    quadrants = [0, 0, 0, 0]
    w = w // 2
    h = h // 2
    for (x, y), vs in grid.items():
        if x < w:
            if y < h:
                quadrants[0] += len(vs)
            elif y > h:
                quadrants[1] += len(vs)
        elif x > w:
            if y < h:
                quadrants[2] += len(vs)
            elif y > h:
                quadrants[3] += len(vs)
    return functools.reduce(lambda x, y: x * y, quadrants, 1)

def part2(data):
    if len(data) < 100:
        w, h = 11, 7
    else:
        w, h = 101, 103
    grid = {}
    for x, y, vx, vy in data:
        p = (x, y)
        if not p in grid:
            grid[p] = set()
        grid[p].add((vx, vy))
    s = 0
    while True:
        s += 1
        after = {}
        for p, vs in grid.items():
            x, y = p
            for v in vs:
                vx, vy = v
                q = (x + vx) % w, (y + vy) % h
                if not q in after:
                    after[q] = set()
                after[q].add(v)
        grid = after
        print(s)
        for y in range(h):
            for x in range(w):
                p = x, y
                if p in grid:
                    print("#", end="")
                else:
                    print(".", end="")
            print()
        print()

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
