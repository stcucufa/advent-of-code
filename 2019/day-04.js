import { bit, input, numbers } from "./util.js";

const range = numbers(await input(4), "-");

// Part 1

let matches = [];
for (let i = range[0]; i <= range[1]; ++i) {
    const s = i.toString();
    if (/(.)\1/.test(s) && /^1*2*3*4*5*6*7*8*9*$/.test(s)) {
        matches.push(s);
    }
}
console.log(matches.length);

// Part 2

console.log(matches.reduce((z, s) => z + bit(s.match(/(.)\1+/g).map(s => s.length).indexOf(2) >= 0), 0));
