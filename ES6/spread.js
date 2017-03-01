const x = { a: 1, b: 2, c: { d: 5, e: 6 } };
const y = { a: 3, b: 4, c: { d: 7 } };
const overWritten = { ...x, ...y }; // { a: 3, b: 4, c: { d: 7 } }
const merged = { ...x, ...y, c: { ...x.c, ...y.c } }; // { a: 3, b: 4, c: { d: 7, e: 6 } }

