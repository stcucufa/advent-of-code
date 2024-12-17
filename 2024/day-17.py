import math
import pathlib
import re
import sys

def parse(puzzle_input):
    registers, program = puzzle_input.split("\n\n")
    A, B, C = [int(n) for n in re.findall(r"\d+", registers)]
    return (A, B, C), [int(n) for n in re.findall(r"\d+", program)]

def exec(data):
    (A, B, C), program = data
    ip = 0
    out = []

    def combo(y):
        if y <= 3:
            return y
        elif y == 4:
            return A
        elif y == 5:
            return B
        else:
            return C

    while ip < len(program):
        x = program[ip]
        y = program[ip + 1]
        ip += 2
        if x == 0:
            A = A // (2 ** combo(y))
        elif x == 1:
            B = B ^ y
        elif x == 2:
            B = combo(y) % 8
        elif x == 3:
            if A != 0:
                ip = y
        elif x == 4:
            B = B ^ C
        elif x == 5:
            out.append(combo(y) % 8)
        elif x == 6:
            B = A // (2 ** combo(y))
        else:
            C = A // (2 ** combo(y))
    return out

def part1(data):
    return ",".join(map(str, exec(data)))

def part2(data):
    (_, b, c), program = data
    n = len(program)

    queue = [(0, len(program) - 1)]
    min = math.inf
    while len(queue) > 0:
        z, i = queue.pop()
        for j in range(8):
            a = z + j * 8 ** i
            out = exec(((a, b, c), program))
            if len(out) > i and out[i] == program[i]:
                if i == 0:
                    if a < min:
                        min = a
                else:
                    queue.append((a, i - 1))
    return min

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
