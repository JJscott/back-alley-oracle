export default (text) => {
  const titles = {
    d: 'defense',
    i: 'intellect',
    h: 'life',
    p: 'power',
    r: 'resource',
    p1: 'pitch 1',
    p2: 'pitch 2',
    p3: 'pitch 3',
  };

  const mod = text.replace(
    /{([dihpr]|p[123])}/g,
    (match, p1) => {
      return `<abbr class="card-symbol card-symbol-${p1}" title="${titles[p1]}">${match}</abbr>`;
    }
  );

  return mod;
}