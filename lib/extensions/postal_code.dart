bool? validateCanadianPostalCode(String? value) {
  if (value == null || value.isEmpty) {
    return false;
  }

  // Canadian postal code regex pattern: A1A 1A1 or A1A1A1
  final regex =
      RegExp(r'^[A-Za-z]\d[A-Za-z] ?\d[A-Za-z]\d$', caseSensitive: false);

  if (!regex.hasMatch(value)) {
    return false;
  }

  // Optionally, you could standardize the format by adding a space if missing
  if (value.length == 6) {
    value = value.substring(0, 3) + ' ' + value.substring(3);
  }

  return true;
}
