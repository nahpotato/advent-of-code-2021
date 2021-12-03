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

  var oxygen = filter_oxygen (array, 0);
  var co2 = filter_co2 (array, 0);

  print ("%u\n", uint.parse (oxygen, 2) * uint.parse (co2, 2));

  return Posix.EXIT_SUCCESS;
}

string filter_co2 (string[] array, uint idx) {
  var zero_amount = 0U;
  var one_amount = 0U;

  foreach (var item in array) {
    if (item[idx] == '0') zero_amount++;
    if (item[idx] == '1') one_amount++;
  }

  var new_array = new string[0];

  if (zero_amount <= one_amount) {
    foreach (var item in array) {
      if (item[idx] == '0') new_array += item;
    }
  }

  if (zero_amount > one_amount) {
    foreach (var item in array) {
      if (item[idx] == '1') new_array += item;
    }
  }

  if (new_array.length == 1)
    return new_array[0];

  return filter_co2 (new_array, idx + 1);
}

string filter_oxygen (string[] array, uint idx) {
  var zero_amount = 0U;
  var one_amount = 0U;

  foreach (var item in array) {
    if (item[idx] == '0') zero_amount++;
    if (item[idx] == '1') one_amount++;
  }

  var new_array = new string[0];

  if (zero_amount > one_amount) {
    foreach (var item in array) {
      if (item[idx] == '0') new_array += item;
    }
  }

  if (zero_amount <= one_amount) {
    foreach (var item in array) {
      if (item[idx] == '1') new_array += item;
    }
  }

  if (new_array.length == 1)
    return new_array[0];

  return filter_oxygen (new_array, idx + 1);
}
