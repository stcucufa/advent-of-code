// cc -Wall -std=c23 -o day-03 day-03.c && ./day-03

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char input[] = {
#ifdef EXAMPLE
#embed "example-03.txt"
#else
#embed "input-03.txt"
#endif
};

static size_t joltage(size_t n) {
    char* in = strdup(input);
    char* tofree = in;
    char* p;
    size_t z = 0;
    while ((p = strsep(&in, "\n"))) {
        size_t l = strlen(p) - n;
        char* digits = calloc(n + 1, 1);
        size_t offset = 0;
        for (size_t i = 0; i < n; ++i) {
            for (size_t j = offset; j <= l; ++j) {
                if (p[j] > digits[i]) {
                    digits[i] = p[j];
                    offset = j + 1;
                }
            }
            l += 1;
        }
        z += strtol(digits, nullptr, 10);
    }
    free(tofree);
    return z;
}

int main(int argc, [[maybe_unused]] char* argv[argc + 1]) {
    printf("%zu\n", joltage(2));
    printf("%zu\n", joltage(12));
    return EXIT_SUCCESS;
}
