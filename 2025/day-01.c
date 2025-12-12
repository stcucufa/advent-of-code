#include <stdio.h>
#include <stdlib.h>
#include <sys/errno.h>

#define INPUT_FILE "input-01.txt"

void part1(FILE* input) {
    int dial = 50;
    int zeros = 0;
    char direction;
    int steps;
    while (fscanf(input, "%c%d\n", &direction, &steps) == 2) {
        dial = (dial + (direction == 'L' ? (100 - steps) : steps)) % 100;
        zeros += dial == 0 ? 1 : 0;
    }
    printf("%d\n", zeros);
}

void part2(FILE* input) {
    int dial = 50;
    int zeros = 0;
    char direction;
    int steps;
    while (fscanf(input, "%c%d\n", &direction, &steps) == 2) {
        zeros += steps / 100;
        int s = steps % 100;
        dial = dial + (direction == 'L' ? (dial == 0 ? 100 - s : -s) : s);
        zeros += dial <= 0 || dial >= 100 ? 1 : 0;
        dial = (dial + 100) % 100;
    }
    printf("%d\n", zeros);
}

int main(int argc, [[maybe_unused]] char* argv[argc + 1]) {
    char* path = argc > 1 ? argv[1] : INPUT_FILE;
    FILE* input = fopen(path, "r");
    if (!input) {
        fprintf(stderr, "Could not open file %s for reading: error %d\n", path, errno);
        return EXIT_FAILURE;
    }

    part1(input);
    rewind(input);
    part2(input);

    fclose(input);
    return EXIT_SUCCESS;
}

