// cc -Wall -std=c23 -o day-02 day-02.c && ./day-02

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char input[] = {
#ifdef EXAMPLE
#embed "example-02.txt"
#else
#embed "input-02.txt"
#endif
};

static void part1() {
    char* in = strdup(input);
    char* tofree = in;
    char* p;
    long z = 0;
    while ((p = strsep(&in, ","))) {
        long begin = strtol(strsep(&p, "-"), nullptr, 10);
        long end = strtol(p, nullptr, 10);
        for (long i = begin; i <= end; ++i) {
            sprintf(p, "%ld", i);
            size_t l = strlen(p);
            if (l % 2 == 0) {
                l /= 2;
                if (!strncmp(p, p + l, l)) {
                    z += i;
                }
            }
        }
    }
    free(tofree);
    printf("%ld\n", z);
}

static void part2() {
    char* in = strdup(input);
    char* tofree = in;
    char* p;
    long z = 0;
    while ((p = strsep(&in, ","))) {
        long begin = strtol(strsep(&p, "-"), nullptr, 10);
        long end = strtol(p, nullptr, 10);
        for (long i = begin; i <= end; ++i) {
            sprintf(p, "%ld", i);
            size_t l = strlen(p);
            for (size_t j = 1; j <= l / 2; ++j) {
                if (l % j == 0) {
                    size_t k = (l / j) - 1;
                    for (; k > 0; k--) {
                        if (strncmp(p, p + k * j, j)) {
                            break;
                        }
                    }
                    if (k == 0) {
                        z += i;
                        break;
                    }
                }
            }
        }
    }
    free(tofree);
    printf("%ld\n", z);
}

int main(int argc, [[maybe_unused]] char* argv[argc + 1]) {
    part1();
    part2();
    return EXIT_SUCCESS;
}
