import pathlib
import sys

Dirs = [(0, -1), (1, 0), (0, 1), (-1, 0)]

def parse(puzzle_input):
    grid = [list(line) for line in puzzle_input.split("\n")]
    for y, row in enumerate(grid):
        for x, cell in enumerate(row):
            if grid[y][x] == "S":
                return grid, x, y

def cheat(data, D):
    grid, x, y = data
    times = { (x, y): 0 }
    while grid[y][x] != "E":
        for dx, dy in Dirs:
            xx, yy = x + dx, y + dy
            if grid[yy][xx] != "#" and not (xx, yy) in times:
                x = xx
                y = yy
                times[(x, y)] = len(times)
    cheats = {}
    for p, t in times.items():
        x, y = p
        for dy in range(-D, D + 1):
            for dx in range(-D, D + 1):
                d = abs(dx) + abs(dy)
                if d > 1 and d <= D:
                    q = (x + dx, y + dy)
                    if q in times:
                        dt = times[q] - t - d
                        if dt > 0:
                            cheats[(p, q)] = dt
    m = 100 if len(times) > 100 else 50
    return sum(1 if dt >= m else 0 for dt in cheats.values())

def part1(data):
    return cheat(data, 2)

def part2(data):
    return cheat(data, 20)

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
