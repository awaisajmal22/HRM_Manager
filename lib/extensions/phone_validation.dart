bool? validateCanadianPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    // Canadian phone number regex pattern
    final regex = RegExp(r'^\(?([2-9][0-9]{2})\)?[-.●]?([2-9][0-9]{2})[-.●]?([0-9]{4})$');

    if (!regex.hasMatch(value)) {
      return false;
    }

    return true;
  }