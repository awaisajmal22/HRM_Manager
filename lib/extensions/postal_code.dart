bool validateCanadianPostalCode(String? value) {
  if (value == null || value.isEmpty) {
    return false;
  }

  // Canadian postal code regex patterns: A1A 1A1 or A0A
  // final regex = RegExp(r'^[A-Za-z]\d[A-Za-z]( \d[A-Za-z]\d)?$');

  if (value.length < 3) {
    return false;
  }

  if (value.length > 6) {
    return false;
  }
  return true;
}
