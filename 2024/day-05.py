import functools
import pathlib
import sys

def parse(puzzle_input):
    rules, updates = puzzle_input.split("\n\n")
    before = {}
    after = {}
    for line in rules.split("\n"):
        p, q = [int(n) for n in line.split("|")]
        if not p in before:
            before[p] = set()
        before[p].add(q)
        if not q in after:
            after[q] = set()
        after[q].add(p)
    return [
        before, after,
        [[int(n) for n in ns] for ns in [line.split(",") for line in updates.split("\n")]]
    ]

def rules_sort(before, after, update):
    def rules_cmp(a, b):
        if a in before and b in before[a]:
            return -1
        if b in after and a in after[b]:
            return 1
        return 0
    return sorted(update, key=functools.cmp_to_key(rules_cmp))

def part1(data):
    before, after, updates = data
    return sum(u[len(u) // 2] for u in updates if rules_sort(before, after, u) == u)

def part2(data):
    before, after, updates = data
    updates = [[rules_sort(before, after, u), u] for u in updates]
    return sum(u[0][len(u[0]) // 2] for u in updates if u[0] != u[1])

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
