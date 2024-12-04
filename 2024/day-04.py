import pathlib
import sys

def parse(puzzle_input):
    return [list(line) for line in puzzle_input.split("\n")]

def part1(data):
    h = len(data)
    w = len(data[0])
    z = 0
    for i in range(h):
        for j in range(w):
            if data[i][j] == 'X':
                if i < h - 3 and data[i + 1][j] == 'M' and data[i + 2][j] == 'A' and data[i + 3][j] == 'S':
                    z += 1
                if j < w - 3 and data[i][j + 1] == 'M' and data[i][j + 2] == 'A' and data[i][j + 3] == 'S':
                    z += 1
                if i < h - 3 and j < w - 3 and \
                    data[i + 1][j + 1] == 'M' and data[i + 2][j + 2] == 'A' and data[i + 3][j + 3] == 'S':
                    z += 1
                if i < h - 3 and j >= 3 and \
                    data[i + 1][j - 1] == 'M' and data[i + 2][j - 2] == 'A' and data[i + 3][j - 3] == 'S':
                    z += 1
                if i >= 3 and data[i - 1][j] == 'M' and data[i - 2][j] == 'A' and data[i - 3][j] == 'S':
                    z += 1
                if j >= 3 and data[i][j - 1] == 'M' and data[i][j - 2] == 'A' and data[i][j - 3] == 'S':
                    z += 1
                if i >= 3 and j < w - 3 and \
                    data[i - 1][j + 1] == 'M' and data[i - 2][j + 2] == 'A' and data[i - 3][j + 3] == 'S':
                    z += 1
                if i >= 3 and j >= 3 and \
                    data[i - 1][j - 1] == 'M' and data[i - 2][j - 2] == 'A' and data[i - 3][j - 3] == 'S':
                    z += 1
    return z

def part2(data):
    h = len(data)
    w = len(data[0])
    z = 0
    for i in range(1, h - 1):
        for j in range(1, w - 1):
            if data[i][j] == 'A':
                if data[i - 1][j - 1] == 'M' and data[i - 1][j + 1] == 'S' and \
                    data[i + 1][j - 1] == 'M' and data[i + 1][j + 1] == 'S':
                    z += 1
                if data[i - 1][j - 1] == 'S' and data[i - 1][j + 1] == 'M' and \
                    data[i + 1][j - 1] == 'S' and data[i + 1][j + 1] == 'M':
                    z += 1
                if data[i - 1][j - 1] == 'S' and data[i - 1][j + 1] == 'S' and \
                    data[i + 1][j - 1] == 'M' and data[i + 1][j + 1] == 'M':
                    z += 1
                if data[i - 1][j - 1] == 'M' and data[i - 1][j + 1] == 'M' and \
                    data[i + 1][j - 1] == 'S' and data[i + 1][j + 1] == 'S':
                    z += 1
    return z

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
