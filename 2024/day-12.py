import pathlib
import sys

def parse(puzzle_input):
    return [list(line) for line in puzzle_input.split("\n")]

def all_patches(grid):
    patches = []
    patch_index = {}
    for y, row in enumerate(grid):
        for x, plant in enumerate(row):
            if y > 0 and grid[y - 1][x] == plant:
                i = patch_index[x, y - 1]
                if x > 0 and grid[y][x - 1] == plant:
                    j = patch_index[x - 1, y]
                    if i != j:
                        patches[i] += patches[j]
                        for p in patches[j]:
                            patch_index[p] = i
            elif x > 0 and grid[y][x - 1] == plant:
                i = patch_index[x - 1, y]
            else:
                i = len(patches)
                patches.append([])
            patch_index[x, y] = i
            patches[i].append((x, y))
    return [patches[i] for i in set(patch_index.values())]

def perimeter(patch):
    positions = set(patch)
    perimeter = 0
    for x, y in patch:
        perimeter += 4
        if (x - 1, y) in positions:
            perimeter -= 1
        if (x + 1, y) in positions:
            perimeter -= 1
        if (x, y - 1) in positions:
            perimeter -= 1
        if (x, y + 1) in positions:
            perimeter -= 1
    return perimeter

def corners(patch):
    edges = set()
    for x, y in patch:
        for edge in [(x, y, x + 1, y), (x, y + 1, x + 1, y + 1), (x + 1, y, x + 1, y + 1), (x, y, x, y + 1)]:
            if edge in edges:
                edges.remove(edge)
            else:
                edges.add(edge)
    corners = 0
    for edge in edges:
        x0, y0, x1, y1 = edge
        if x0 == x1:
            if (x0, y0, x0 + 1, y0) in edges:
                corners += 1
            elif (x0 - 1, y0, x0, y0) in edges:
                corners += 1
            if (x0, y1, x0 + 1, y1) in edges:
                corners += 1
            elif (x0 - 1, y1, x0, y1) in edges:
                corners += 1
    return corners

def part1(grid):
    return sum(len(patch) * perimeter(patch) for patch in all_patches(grid))

def part2(grid):
    return sum(len(patch) * corners(patch) for patch in all_patches(grid))

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
