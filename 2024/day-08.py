import pathlib
import sys

def parse(puzzle_input):
    return [list(line) for line in puzzle_input.split("\n")]

def part1(grid):
    h = len(grid)
    w = len(grid[0])
    antennas = {}
    for y, row in enumerate(grid):
        for x, c in enumerate(row):
            if c != ".":
                if not c in antennas:
                    antennas[c] = []
                antennas[c].append((x, y))
    antinodes = set()
    for positions in antennas.values():
        n = len(positions)
        for i in range(n - 1):
            px, py = positions[i]
            for j in range(i + 1, n):
                qx, qy = positions[j]
                dx, dy = px - qx, py - qy
                xx, yy = px + dx, py + dy
                if xx >= 0 and xx < w and yy >= 0 and yy < h:
                    antinodes.add((xx, yy))
                xx, yy = qx - dx, qy - dy
                if xx >= 0 and xx < w and yy >= 0 and yy < h:
                    antinodes.add((xx, yy))
    return len(antinodes)

def part2(grid):
    h = len(grid)
    w = len(grid[0])
    antennas = {}
    for y, row in enumerate(grid):
        for x, c in enumerate(row):
            if c != ".":
                if not c in antennas:
                    antennas[c] = []
                antennas[c].append((x, y))
    antinodes = set()
    for positions in antennas.values():
        n = len(positions)
        for i in range(n - 1):
            px, py = positions[i]
            for j in range(i + 1, n):
                qx, qy = positions[j]
                dx, dy = px - qx, py - qy
                xx, yy = px, py
                while xx >= 0 and xx < w and yy >= 0 and yy < h:
                    antinodes.add((xx, yy))
                    xx, yy = xx + dx, yy + dy
                xx, yy = qx, qy
                while xx >= 0 and xx < w and yy >= 0 and yy < h:
                    antinodes.add((xx, yy))
                    xx, yy = xx - dx, yy - dy
    return len(antinodes)

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
