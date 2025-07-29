import { input, numbers } from "./util.js";

(async function() {
    const memory = numbers(await input(2), ",");

    function run(noun, verb) {
        const m = memory.slice();
        m[1] = noun;
        m[2] = verb;
        for (let i = 0; m[i] !== 99; i += 4) {
            if (m[i] === 1) {
                m[m[i + 3]] = m[m[i + 1]] + m[m[i + 2]];
            } else {
                m[m[i + 3]] = m[m[i + 1]] * m[m[i + 2]];
            }
        }
        return m[0];
    }

    // Part 1

    console.log(run(12, 2));

    // Part 2

    for (let noun = 0; noun < 100; ++noun) {
        for (let verb = 0; verb < 100; ++verb) {
            if (run(noun, verb) === 19690720) {
                console.log(100 * noun + verb);
                return;
            }
        }
    }

}());
