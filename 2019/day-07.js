import { bit, input, K, max, numbers } from "./util.js";

const memory = numbers(await input(7), ",");

function run(input, output) {
    const m = memory.slice();
    let ip = 0;

    const fetch = mode => mode === 0 ? m[m[ip++]] : m[ip++];
    const store = value => m[m[ip++]] = value;

    while (true) {
        const [a, b, c, d, e] = numbers(m[ip++].toString().padStart(5, "0"), "");
        const op = d * 10 + e;
        if (op === 1) {
            console.assert(a === 0);
            store(fetch(c) + fetch(b));
        } else if (op === 2) {
            console.assert(a === 0);
            store(fetch(c) * fetch(b));
        } else if (op === 3) {
            console.assert(c === 0);
            store(input());
        } else if (op === 4) {
            output(fetch(c));
        } else if (op === 5) {
            const p = fetch(c);
            const dest = fetch(b);
            if (p !== 0) {
                ip = dest;
            }
        } else if (op === 6) {
            const p = fetch(c);
            const dest = fetch(b);
            if (p === 0) {
                ip = dest;
            }
        } else if (op === 7) {
            console.assert(a === 0);
            store(bit(fetch(c) < fetch(b)));
        } else if (op === 8) {
            console.assert(a === 0);
            store(bit(fetch(c) === fetch(b)));
        } else {
            break;
        }
    }
}

// Part 1

function permutations(xs) {
    const n = xs.length;
    if (n === 1) {
        return [xs];
    }
    const zs = [];
    for (let i = 0; i < n; ++i) {
        const [y, ...ys] = xs;
        for (const z of permutations(ys)) {
            zs.push([y, ...z]);
        }
        xs = [...ys, y];
    }
    return zs;
}

console.log(max(permutations([0, 1, 2, 3, 4]).map(phases => {
    let power = 0;
    let k = 0;
    for (let i = 0; i < 5; ++i) {
        run(() => (k++ % 2) === 0 ? phases.shift() : power, value => { power = value; });
    }
    return power;
})));

// Part 2
