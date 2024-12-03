import pathlib
import re
import sys

def parse(puzzle_input):
    return puzzle_input

def part1(data):
    p = re.compile(r"mul\((\d+),(\d+)\)")
    return sum(int(x) * int(y) for x, y in p.findall(data))

def part2(data):
    p = re.compile(r"mul\((\d+),(\d+)\)|(do|don't)\(\)")
    do = True
    z = 0
    for (x, y, cmd) in p.findall(data):
        if cmd == "do":
            do = True
        elif cmd == "don't":
            do = False
        elif do:
            z += int(x) * int(y)
    return z

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
