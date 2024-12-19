import functools
import pathlib
import sys

def parse(puzzle_input):
    patterns, designs = puzzle_input.split("\n\n")
    return set([p.strip() for p in patterns.split(",")]), designs.split("\n")

def is_design_possible(patterns, design):
    queue = [design]
    seen = set()
    while len(queue) > 0:
        d = queue.pop()
        if not d in seen:
            seen.add(d)
            if d in patterns:
                return True
            for p in patterns:
                if d.startswith(p):
                    queue.append(d[len(p):])
    return False

def part1(data):
    patterns, designs = data
    return functools.reduce(lambda z, d: z + 1 if is_design_possible(patterns, d) else z, designs, 0)

def count_combinations(patterns, design):
    count = {}
    def visit(d):
        if d in count:
            return count[d]
        k = 0
        for p in patterns:
            if d == p:
                k += 1
            elif d.startswith(p):
                k += visit(d[len(p):])
        count[d] = k
        return k
    return visit(design)

def part2(data):
    patterns, design = data
    return sum(count_combinations(patterns, d) for d in design)

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
