export const bit = p => p ? 1 : 0;
export const input = async n => await Bun.file(`input-${n.toString().padStart(2, "0")}.txt`).text();
export const min = xs => xs.reduce((z, x) => Math.min(z, x), Infinity);
export const numbers = (input, sep = "\n") => input.split(sep).map(n => parseInt(n, 10));
export const sum = xs => xs.reduce((z, x) => z + x, 0);
