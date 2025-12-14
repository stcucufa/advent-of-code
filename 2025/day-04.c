// cc -Wall -std=c23 -o day-04 day-04.c && ./day-04

#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char input[] = {
#ifdef EXAMPLE
#embed "example-04.txt"
#else
#embed "input-04.txt"
#endif
};

static ptrdiff_t dx[8] = { -1, 0, 1, -1, 1, -1, 0, 1 };
static ptrdiff_t dy[8] = { -1, -1, -1, 0, 0, 1, 1, 1 };

static size_t neighbours(char* grid, size_t width, size_t height, size_t x, size_t y) {
    size_t n = 0;
    for (size_t j = 0; j < 8; ++j) {
        ptrdiff_t xx = x + dx[j];
        ptrdiff_t yy = y + dy[j];
        n += (xx >= 0 && xx < width && yy >= 0 && yy < height && grid[xx + yy * (width + 1)] == '@');
    }
    return n;
}

static size_t part1(char* grid, size_t width, size_t height) {
    size_t z = 0;
    for (size_t x = 0; x < width; ++x) {
        for (size_t y = 0; y < height; ++y) {
            if (grid[x + y * (width + 1)] == '@') {
                z += neighbours(grid, width, height, x, y) < 4;
            }
        }
    }
    return z;
}

static size_t part2(char* grid, size_t width, size_t height) {
    size_t z = 0;
    size_t count = height * (width + 1);
    char* g = calloc(count, 1);
    while (true) {
        memcpy(g, grid, count);
        size_t n = 0;
        for (size_t x = 0; x < width; ++x) {
            for (size_t y = 0; y < height; ++y) {
                size_t i = x + y * (width + 1);
                if (grid[i] == '@' && neighbours(grid, width, height, x, y) < 4) {
                    n += 1;
                    g[i] = '.';
                }
            }
        }
        if (n == 0) {
            free(g);
            return z;
        }
        z += n;
        grid = g;
    }
}

int main(int argc, [[maybe_unused]] char* argv[argc + 1]) {
    size_t width = 0;
    size_t height = 0;
    char* in = strdup(input);
    char* grid = in;
    for (char* p; (p = strsep(&in, "\n"));) {
        width = strlen(p);
        height += 1;
    }
    printf("%zu\n", part1(grid, width, height));
    printf("%zu\n", part2(grid, width, height));
    free(grid);
    return EXIT_SUCCESS;
}
