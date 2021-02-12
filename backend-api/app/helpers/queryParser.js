// uncatagorized values are put under "name"
const parse = (query, aliases, flatten=false) => {
  let obj = {};

  // default for cards
  obj['name'] = {};
  obj['name'][':'] = [];

  if (query) {

    // regex matching groups
    // 0) all
    // 1) name : non whitespace/quoted string followed by an operator (optional)
    // 2) operator : sequence of any <>=: (optional)
    // 3) value : quoted string (with escaped quotes and whitespace) or non-whitespace string
    const matches = query.matchAll(/(?:([^\s"<>=!:]+)([<>]=?|!?[=:]))?("(?:\\.|[^"])*"|[^\s"]+)/g);
    
    for (const match of matches) {
      // console.log(match);

      // set parameter name, op, and value (name and = by default)
      let name = typeof (match[1]) === 'undefined' ? 'name' : match[1];
      let op = typeof (match[2]) === 'undefined' ? ':' : match[2];
      let value = match[3];

      // make key lower case and replace aliases
      let key = name.toLowerCase();
      if (aliases && aliases.hasOwnProperty(key)) {
        key = aliases[key];
      }

      // replace double quotes in value
      value = value.replace(/\\(?=")|^"|"$/g, '')

      // if there's no KEY
      if (!obj.hasOwnProperty(key)) {
        obj[key] = {};
        obj[key][op] = value;
      }
      // if there's no OP for this KEY
      else if (!obj[key].hasOwnProperty(op)){ 
        obj[key][op] = value;
      }
      else if (!Array.isArray(obj[key][op])) {
        // convert to array
        obj[key][op] = [obj[key][op]];
        obj[key][op].push(value);
      } else {
        // push new value
        obj[key][op].push(value);
      }
    }
  }


  // flatten into an array
  if (flatten) {
    const flat = []
    for (const [key, opValue] of Object.entries(obj)) {
      for (const [op, value] of Object.entries(opValue)) {
        flat.push({key: key, op: op, value: value})
      }
    }
    obj = flat;
  }

  return obj;
};

module.exports = {
  parse
}