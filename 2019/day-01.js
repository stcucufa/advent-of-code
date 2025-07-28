import { numbers, sum } from "./util.js";

const masses = numbers(await Bun.file("input-01.txt").text());

// Part 1

const fuel = mass => Math.floor(mass / 3) - 2;
console.log(sum(masses.map(fuel)));

// Part 2

function fuelRec(m) {
    let f = fuel(m);
    return f <= 0 ? 0 : f + fuelRec(f);
}
console.log(sum(masses.map(fuelRec)));
