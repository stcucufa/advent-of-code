import pathlib
import sys

def parse(puzzle_input):
    return [int(n) for n in list(puzzle_input)]

def expand(data):
    data = data[:]
    data.append(0)
    blocks = []
    free = []
    files = []
    offset = 0
    for i in range(0, len(data), 2):
        id = i // 2
        m, n = data[i], data[i + 1]
        for j in range(m):
            blocks.append(id)
        for j in range(n):
            blocks.append(None)
        files.append((offset, m))
        if n > 0:
            free.append((offset + m, n))
        offset += m + n
    return blocks, files, free

def compact(blocks, _, free):
    offset = free.pop(0)[0]
    for i in reversed(range(len(blocks))):
        if offset >= i:
            return blocks
        b = blocks[i]
        if b != None:
            blocks[i] = None
            blocks[offset] = b 
            offset += 1
            if blocks[offset] != None:
                if len(free) == 0:
                    return blocks
                offset = free.pop(0)[0]
    return blocks

def find_free(pos, size, free):
    for i in range(len(free)):
        offset, remain = free[i]
        if offset > pos:
            return None
        if remain >= size:
            return i
    return None

def defrag(blocks, files, free):
    for i in reversed(range(len(files))):
        pos, size = files[i]
        j = find_free(pos, size, free)
        if j != None:
            offset, remain = free[j]
            free[j] = offset + size, remain - size
            for k in range(size):
                blocks[offset + k] = i
                blocks[pos + k] = None
    return blocks

def checksum(blocks):
    checksum = 0
    for i, b in enumerate(blocks):
        if b != None:
            checksum += i * b
    return checksum

def part1(data):
    return checksum(compact(*expand(data)))

def part2(data):
    return checksum(defrag(*expand(data)))

def solve(puzzle_input):
    data = parse(puzzle_input)
    return part1(data), part2(data)

if __name__ == "__main__":
    for path in sys.argv[1:]:
        print(f"{path}:")
        puzzle_input = pathlib.Path(path).read_text().strip()
        print("\n".join(str(solution) for solution in solve(puzzle_input)))
