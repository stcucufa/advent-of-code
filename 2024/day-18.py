import pathlib
import sys

from collections import deque

def parse(puzzle_input):
    return [tuple(map(int, line.split(","))) for line in puzzle_input.split("\n")]

def draw(grid, w, h, path):
    for y in range(h):
        for x in range(w):
            if (x, y) in path:
                print("O", end="")
            else:
                print("#" if (x, y) in grid else ".", end="")
        print()

def find_path(grid, w, h):
    queue = deque([(0, 0, set())])
    visited = set()
    while len(queue) > 0:
        x, y, path = queue.pop()
        if x < 0 or y < 0 or x >= w or y >= h or (x, y) in grid or (x, y) in visited:
            continue
        visited.add((x, y))
        if x == w - 1 and y == h - 1:
            return path
        path = path.copy()
        path.add((x, y))
        queue.appendleft((x + 1, y, path))
        queue.appendleft((x, y + 1, path))
        queue.appendleft((x - 1, y, path))
        queue.appendleft((x, y - 1, path))

def part1(data):
    w, h, n = (71, 71, 1024) if len(data) > 1024 else (7, 7, 12)
    grid = set()
    for p in data[:n]:
        grid.add(p)
    path = find_path(grid, w, h)
    draw(grid, w, h, path)
    return len(path) - 1

def part2(data):
    w, h, n = (71, 71, 1024) if len(data) > 1024 else (7, 7, 12)
    grid = set()
    for p in data[:n]:
        grid.add(p)
    path = find_path(grid, w, h)
    for i in range(n, len(data)):
        grid.add(data[i])
        if data[i] in path:
            path = find_path(grid, w, h)
            if path == None:
                return "{},{}".format(*data[i])

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
