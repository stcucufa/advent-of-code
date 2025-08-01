import { bit, input, K, numbers } from "./util.js";

const memory = numbers(await input(5), ",");

function run(input) {
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
            console.log(fetch(c));
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

run(K(1));

// Part 2

run(K(5));
