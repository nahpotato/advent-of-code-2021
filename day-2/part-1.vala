int main (string[] args) {
  if (args.length != 2) {
    printerr ("usage: %s INPUT\n", args[0]);
    return Posix.EXIT_FAILURE;
  }

  string input;

  try {
    FileUtils.get_contents (args[1], out input);
  } catch (Error err) {
    printerr ("An error ocurred while reading the input: %s\n", err.message);
    return Posix.EXIT_FAILURE;
  }

  var array = input.split ("\n");
  var regex = /([a-z]+).*([0-9]+)/i;

  var state = fold<string, State?> (array, {}, (state, item) => {
    MatchInfo info;
    regex.match (item, 0, out info);

    var order = info.fetch (1);
    var amount = info.fetch (2);

    switch (order?.down () ?? "") {
      case "forward":
        state.hpos += uint.parse (amount);
        break;

      case "down":
        state.depth += uint.parse (amount);
        break;

      case "up":
        state.depth -= uint.parse (amount);
        break;
    }

    return state;
  });

  print ("%u\n", state.hpos * state.depth);

  return Posix.EXIT_SUCCESS;
}

struct State {
  uint hpos;
  uint depth;
}

V fold<G,V> (G[] array, V initial, FoldFunc<G,V> func) {
  var current = initial;

  foreach (var item in array) {
    current = func (current, item);
  }

  return current;
}

delegate V FoldFunc<G,V> (V previous, G current);
