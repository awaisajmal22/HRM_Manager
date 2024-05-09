int calculateAge(DateTime birthDate) {
  final now = DateTime.now();
  int years = now.year - birthDate.year;

  // Adjust age based on the current month and day compared to the birthdate
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    years--;
  }

  return years;
}