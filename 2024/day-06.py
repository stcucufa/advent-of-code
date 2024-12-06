import pathlib
import sys

dirs = [(0, -1), (1, 0), (0, 1), (-1, 0)]

def parse(puzzle_input):
    return [list(line) for line in puzzle_input.split("\n")]

def find_guard(grid):
    h = len(grid)
    for y in range(h):
        row = grid[y]
        if row.count('^') > 0:
            return row.index('^'), y, len(row), h, 0

def visited_cells(grid):
    visited = set()
    x, y, w, h, d = find_guard(grid)
    while True:
        visited.add((x, y))
        dx, dy = dirs[d]
        xx = x + dx
        yy = y + dy
        if xx < 0 or xx >= w or yy < 0 or yy >= h:
            return visited
        if grid[yy][xx] == '#':
            d = (d + 1) % 4
        else:
            x = xx
            y = yy

def has_cycle(grid):
    visited = set()
    x, y, w, h, d = find_guard(grid)
    while True:
        if (x, y, d) in visited:
            return True
        visited.add((x, y, d))
        dx, dy = dirs[d]
        xx = x + dx
        yy = y + dy
        if xx < 0 or xx >= w or yy < 0 or yy >= h:
            return False
        if grid[yy][xx] == '#':
            d = (d + 1) % 4
        else:
            x = xx
            y = yy

def part1(grid):
    return len(visited_cells(grid))

def part2(grid):
    visited = visited_cells(grid)
    z = 0
    for x, y in visited:
        if grid[y][x] == '.':
            grid[y][x] = '#'
            if has_cycle(grid):
                z += 1
            grid[y][x] = '.'
    return z

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
