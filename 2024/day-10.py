import pathlib
import sys

def parse(puzzle_input):
    return [[int(n) for n in list(line)] for line in puzzle_input.split("\n")]

def score_trailhead(grid, w, h, x, y):
    queue = [(x, y)]
    visited = set()
    while len(queue) > 0:
        x, y = queue.pop()
        visited.add((x, y))
        z = grid[y][x]
        if x > 0 and grid[y][x - 1] - z == 1 and not (x - 1, y) in visited:
            queue.append((x - 1, y))
        if x < w - 1 and grid[y][x + 1] - z == 1 and not (x + 1, y) in visited:
            queue.append((x + 1, y))
        if y > 0 and grid[y - 1][x] - z == 1 and not (x, y - 1) in visited:
            queue.append((x, y - 1))
        if y < h - 1 and grid[y + 1][x] - z == 1 and not (x, y + 1) in visited:
            queue.append((x, y + 1))
    return sum(1 for x, y in visited if grid[y][x] == 9)

def part1(grid):
    h = len(grid)
    w = len(grid[0])
    score = 0
    for y, row in enumerate(grid):
        for x, z in enumerate(row):
            if z == 0:
                score += score_trailhead(grid, w, h, x, y)
    return score

def rate_trailhead(grid, w, h, x, y):
    queue = [(x, y)]
    rating = 0
    while len(queue) > 0:
        x, y = queue.pop()
        z = grid[y][x]
        if z == 9:
            rating += 1
        else:
            if x > 0 and grid[y][x - 1] - z == 1:
                queue.append((x - 1, y))
            if x < w - 1 and grid[y][x + 1] - z == 1:
                queue.append((x + 1, y))
            if y > 0 and grid[y - 1][x] - z == 1:
                queue.append((x, y - 1))
            if y < h - 1 and grid[y + 1][x] - z == 1:
                queue.append((x, y + 1))
    return rating

def part2(grid):
    h = len(grid)
    w = len(grid[0])
    rating = 0
    for y, row in enumerate(grid):
        for x, z in enumerate(row):
            if z == 0:
                rating += rate_trailhead(grid, w, h, x, y)
    return rating

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
