export const sum = xs => xs.reduce((z, x) => z + x, 0);
export const numbers = input => input.split("\n").map(n => parseInt(n, 10));
