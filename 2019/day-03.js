import { input, min, sum } from "./util.js";

const Directions = { D: [0, 1], L: [-1, 0], R: [1, 0], U: [0, -1] };

function follow(path) {
    let x = 0;
    let y = 0;
    let steps = 0;
    let visited = {};
    for (const p of path) {
        const [dx, dy] = Directions[p[0]];
        for (let i = 0; i < parseInt(p.substring(1)); ++i) {
            x += dx;
            y += dy;
            steps += 1;
            visited[`${x},${y}`] = steps;
        }
    }
    return visited;
}

const paths = (await input(3)).split("\n").map(path => follow(path.split(",")));
const intersections = [...new Set(Object.keys(paths[0])).intersection(new Set(Object.keys(paths[1])))];

// Part 1

console.log(min(intersections.map(key => sum(key.split(",").map(n => Math.abs(parseInt(n, 10)))))));

// Part 2

console.log(min(intersections.map(key => paths[0][key] + paths[1][key])));
