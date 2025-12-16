#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char static_input[] = {
#ifdef EXAMPLE
#embed "example-06.txt"
#else
#embed "input-06.txt"
#endif
};

static constexpr double φ = 1.618033988749895;

typedef struct array array;
struct array {
    void** items;
    size_t count;
    size_t capacity;
};

static void array_init(array* a) {
    a->items = nullptr;
    a->count = 0;
    a->capacity = 0;
}

static void array_free(array* a) {
    if (a->items) {
        free(a->items);
        a->items = nullptr;
        a->count = 0;
        a->capacity = 0;
    }
}

static void* array_push(array* a, void* item) {
    if (a->count == a->capacity) {
        a->capacity = a->capacity == 0 ? 1 : (size_t)ceil((double)a->capacity * φ);
        a->items = realloc(a->items, sizeof(void*) * a->capacity);
    }
    a->items[a->count++] = item;
    return item;
}

static long part1(array* lines, array* widths) {
    long sum = 0;
    size_t h = lines->count - 1;
    char* ops = (char*)lines->items[h];
    for (size_t i = 0; i < widths->count; ++i) {
        size_t offset = (size_t)widths->items[i];
        size_t z = 0;
        if (ops[offset] == '+') {
            for (size_t j = 0; j < h; ++j) {
                z += strtol(offset + (char*)(lines->items[j]), nullptr, 10);
            }
        } else {
            z = 1;
            for (size_t j = 0; j < h; ++j) {
                z *= strtol(offset + (char*)(lines->items[j]), nullptr, 10);
            }
        }
        sum += z;
    }
    return sum;
}

static long part2(array* lines, array* widths) {
    long sum = 0;
    size_t h = lines->count - 1;
    for (size_t i = 0; i < widths->count; ++i) {
        size_t offset = (size_t)widths->items[i];
        char op = ((char*)lines->items[h])[offset];
        size_t w = (i < widths->count - 1 ? (size_t)widths->items[i + 1] - 1 : strlen((char*)lines->items[0])) - offset;
        char* transpose = calloc((h + 1) * w, 1);
        for (size_t j = 0; j < h; ++j) {
            char* token = offset + (char*)lines->items[j];
            for (size_t k = 0; k < w; ++k) {
                transpose[j + k * (h + 1)] = token[k];
            }
        }
        size_t z = 0;
        if (op == '+') {
            for (size_t j = 0; j < h; ++j) {
                z += strtol(transpose + j * (h + 1), nullptr, 10);
            }
        } else {
            z = 1;
            for (size_t j = 0; j < h; ++j) {
                size_t n = strtol(transpose + j * (h + 1), nullptr, 10);
                if (n > 0) {
                    z *= n;
                }
            }
        }
        sum += z;
        free(transpose);
    }
    return sum;
}

int main(int argc, [[maybe_unused]] char* argv[argc + 1]) {
    char* input = strdup(static_input);
    array lines;
    array columns;
    array_init(&lines);
    array_init(&columns);

    for (char* line; (line = strsep(&input, "\n"));) {
        array_push(&lines, (void*)line);
    }

    size_t i = 0;
    char* ops = (char*)lines.items[lines.count - 1];
    for (char* op; (op = strsep(&ops, " "));) {
        if (*op) {
            array_push(&columns, (void*)i);
            i += strlen(op);
        }
        i += 1;
    }


    printf("%zu\n", part1(&lines, &columns));
    printf("%zu\n", part2(&lines, &columns));
    array_free(&lines);
    array_free(&columns);
    free(input);
    return EXIT_SUCCESS;
}
