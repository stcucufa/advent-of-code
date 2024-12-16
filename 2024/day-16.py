import heapq
import math
import pathlib
import sys

# E, S, W, N
Directions = [(1, 0), (0, -1), (-1, 0), (0, 1)]

def parse(puzzle_input):
    grid = [list(line) for line in puzzle_input.split("\n")]
    for y, row in enumerate(grid):
        for x, cell in enumerate(row):
            if cell == "S":
                return grid, x, y

def part1(data):
    grid, xs, ys = data
    visited = {}
    min = math.inf
    queue = [(0, xs, ys, 0)]
    while len(queue) > 0:
        z, x, y, d = heapq.heappop(queue)
        if z < min and z < visited.get((x, y, d), math.inf):
            visited[(x, y, d)] = z
            if grid[y][x] == "E":
                min = z
            elif grid[y][x] == "." or grid[y][x] == "S":
                dx, dy = Directions[d]
                heapq.heappush(queue, (z + 1, x + dx, y + dy, d))
                heapq.heappush(queue, (z + 1000, x, y, (d + 1) % 4))
                heapq.heappush(queue, (z + 1000, x, y, (d - 1) % 4))
    return min

def part2(data, min):
    grid, xs, ys = data
    visited = {}
    paths = []
    queue = [(0, xs, ys, 0, [])]
    while len(queue) > 0:
        z, x, y, d, path = heapq.heappop(queue)
        if z <= min and z <= visited.get((x, y, d), math.inf):
            visited[(x, y, d)] = z
            p = path[:]
            p.append((x, y))
            if grid[y][x] == "E":
                paths.append(p)
            elif grid[y][x] == "." or grid[y][x] == "S":
                dx, dy = Directions[d]
                heapq.heappush(queue, (z + 1, x + dx, y + dy, d, p))
                heapq.heappush(queue, (z + 1000, x, y, (d + 1) % 4, p))
                heapq.heappush(queue, (z + 1000, x, y, (d - 1) % 4, p))
    tiles = set()
    for p in paths:
        for x, y in p:
            tiles.add((x, y))
    return len(tiles)

def solve(puzzle_input):
    data = parse(puzzle_input)
    min = part1(data)
    return min, part2(data, min)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
