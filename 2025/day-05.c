// cc -Wall -O3 -std=c23 -lm -o day-05 day-05.c && ./day-05

#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char static_input[] = {
#ifdef EXAMPLE
#embed "example-05.txt"
#else
#embed "input-05.txt"
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

static bool fresh(long id, array* ranges) {
    for (size_t i = 0; i < ranges->count; i += 2) {
        if (id >= (long)ranges->items[i] && id <= (long)ranges->items[i + 1]) {
            return true;
        }
    }
    return false;
}

static size_t part1(char* ingredients, array* ranges) {
    size_t z = 0;
    for (char* id; (id = strsep(&ingredients, "\n"));) {
        if (fresh(strtol(id, nullptr, 10), ranges)) {
            z += 1;
        }
    }
    return z;
}

static int cmp(void const* a, void const* b) {
    long const* aa = a;
    long const* bb = b;
    return *aa < *bb ? -1 : *aa > *bb ? 1 : 0;
}

static size_t part2(char* ingredients, array* ranges) {
    size_t n = ranges->count;
    size_t width = sizeof(long);
    long* events = calloc(n, width);
    for (size_t i = 0; i < n; ++i) {
        events[i] = (long)ranges->items[i];
    }
    qsort(events, n, width, cmp);
    size_t z = 0;
    bool in = true;
    for (size_t i = 1; i < n; ++i) {
        if (in) {
            z += events[i] - events[i - 1];
        }
        bool next_in = fresh(events[i] + 1, ranges);
        if (in && !next_in) {
            z += 1;
        }
        in = next_in;
    }
    free(events);
    return z;
}

int main(int argc, [[maybe_unused]] char* argv[argc + 1]) {
    char* input = strdup(static_input);
    char* ingredients = strstr(input, "\n\n");
    *ingredients = 0;
    ingredients += 2;
    assert(sizeof(long) == sizeof(void*));
    array ranges;
    array_init(&ranges);
    for (char* end; (end = strsep(&input, "\n"));) {
        char* begin = strsep(&end, "-");
        (void)array_push(&ranges, (void*)strtol(begin, nullptr, 10));
        (void)array_push(&ranges, (void*)strtol(end, nullptr, 10));
    }
    printf("%zu\n", part1(ingredients, &ranges));
    printf("%zu\n", part2(ingredients, &ranges));
    array_free(&ranges);
    free(input);
    return EXIT_SUCCESS;
}
