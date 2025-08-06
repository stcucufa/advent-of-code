import { input } from "./util.js";

const testData = `COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN`;

// const pairs = testData.split("\n").map(line => line.split(")"));
const pairs = (await input(6)).split("\n").map(line => line.split(")"));

const orbits = {};
for (const [x, y] of pairs) {
    if (orbits[x]) {
        orbits[x].push(y);
    } else {
        orbits[x] = [y];
    }
}

// Part 1

const queue = [["COM", 0]];
let checksum = 0;
while (queue.length > 0) {
    const [x, d] = queue.shift();
    checksum += d;
    if (Object.hasOwn(orbits, x)) {
        for (const y of orbits[x]) {
            queue.push([y, d + 1]);
        }
    }
}
console.log(checksum);

// Part 2

const parents = Object.fromEntries(pairs.map(p => p.reverse()));
const distances = {};

function up(x, d) {
    const parent = parents[x];
    if (!parent) {
        return;
    }
    distances[parent] = d;
    up(parent, d + 1);
}

function down(x, d) {
    const parent = parents[x];
    return parent in distances ? d + distances[parent] : down(parent, d + 1);
}

up("YOU", 0);
console.log(down("SAN", 0));
