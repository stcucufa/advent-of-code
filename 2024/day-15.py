import pathlib
import sys

Directions = { "^": (0, -1), "v": (0, 1), "<": (-1, 0), ">": (1, 0) }

def parse(puzzle_input):
    grid, movements = puzzle_input.split("\n\n")
    grid = [list(line) for line in grid.split("\n")]
    wide_grid = []
    for row in grid:
        wide_row = []
        wide_grid.append(wide_row)
        for cell in row:
            if cell == "#":
                wide_row.append("#")
                wide_row.append("#")
            elif cell == "O":
                wide_row.append("[")
                wide_row.append("]")
            elif cell == ".":
                wide_row.append(".")
                wide_row.append(".")
            else:
                wide_row.append("@")
                wide_row.append(".")
    return grid, wide_grid, tuple(movements.replace("\n", ""))

def find_robot(grid):
    for y, row in enumerate(grid):
        for x, cell in enumerate(row):
            if cell == "@":
                return x, y

def push(grid, x, y, dx, dy):
    xx, yy = x + dx, y + dy
    if grid[yy][xx] == "." or (grid[yy][xx] == "O" and push(grid, xx, yy, dx, dy)):
        grid[y][x] = "."
        x = xx
        y = yy
        grid[y][x] = "O"
        return True
    return False

def score(grid):
    z = 0
    for y, row in enumerate(grid):
        for x, cell in enumerate(row):
            if grid[y][x] == "O" or grid[y][x] == "[":
                z += 100 * y + x
    return z

def part1(data):
    grid, _, movements = data
    x, y = find_robot(grid)
    for m in movements:
        dx, dy = Directions[m]
        xx, yy = x + dx, y + dy
        if grid[yy][xx] == "." or (grid[yy][xx] == "O" and push(grid, xx, yy, dx, dy)):
            grid[y][x] = "."
            x = xx
            y = yy
            grid[y][x] = "@"
    return score(grid)

def push_left(grid, x, y, dx):
    xx = x + dx
    c = grid[y][x]
    d = grid[y][xx]
    if d == "." or \
        ((((c == "@" or c == "[") and (d == "]")) or (c == "]" and d == "[")) and push_left(grid, xx, y, dx)):
        grid[y][x] = "."
        grid[y][xx] = c
        return True
    return False

def push_right(grid, x, y, dx):
    xx = x + dx
    c = grid[y][x]
    d = grid[y][xx]
    if d == "." or \
        ((((c == "@" or c == "]") and (d == "[")) or (c == "[" and d == "]")) and push_right(grid, xx, y, dx)):
        grid[y][x] = "."
        grid[y][xx] = c
        return True
    return False

def push_vertical(grid, x, y, dy):
    yy = y + dy
    c = grid[y][x]
    d = grid[yy][x]
    if d == "." or \
        (d == "[" and push_vertical(grid, x, yy, dy) and push_vertical(grid, x + 1, yy, dy)) or \
        (d == "]" and push_vertical(grid, x, yy, dy) and push_vertical(grid, x - 1, yy, dy)):
        grid[y][x] = "."
        grid[yy][x] = c
        return True
    return False

def part2(data):
    narrow, grid, movements = data
    x, y = find_robot(grid)
    for m in movements:
        dx, dy = Directions[m]
        if (dx == -1 and push_left(grid, x, y, dx)) or (dx == 1 and push_right(grid, x, y, dx)):
            x += dx
        else:
            before = [row[:] for row in grid]
            if push_vertical(grid, x, y, dy):
                y += dy
            else:
                grid = before
    return score(grid)

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
