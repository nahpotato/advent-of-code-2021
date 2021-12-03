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

  if (array.length < 2) {
    print ("%u\n", 0U);
    return Posix.EXIT_SUCCESS;
  }

  var result = 0U;

  for (var i = 1U; i < array.length; i++) {
    var previous = uint.parse (array[i - 1]);
    var current = uint.parse (array[i]);

    if (previous < current) result++;
  }

  print ("%u\n", result);

  return Posix.EXIT_SUCCESS;
}
