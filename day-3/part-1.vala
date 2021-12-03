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

  var array = input.strip ().split ("\n");

  var gamma_rate = "";
  var epsilon_rate = "";

  for (var i = 0U; i < array[0].length; i++) {
    var zero_amount = 0U;
    var one_amount = 0U;

    foreach (var item in array) {
      if (item[i] == '0') zero_amount++;
      if (item[i] == '1') one_amount++;
    }

    gamma_rate += zero_amount < one_amount ? "1" : "0";
    epsilon_rate += zero_amount < one_amount ? "0" : "1";
  }

  print ("%u\n", uint.parse (gamma_rate, 2) * uint.parse (epsilon_rate, 2));

  return Posix.EXIT_SUCCESS;
}
