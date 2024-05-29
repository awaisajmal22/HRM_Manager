// bool validateCanadianPhoneNumber(String? value) {
//   if (value == null || value.isEmpty) {
//     return false;
//   }

//   // Canadian phone number regex pattern
//   final regex =
//       RegExp(r'^\+?1?[-.\s]?(\(?\d{3}\)?|\d{3})[-.\s]?\d{3}[-.\s]?\d{4}$');

//   if (!regex.hasMatch(value)) {
//     return false;
//   }

//   return true;
// }
bool validateCanadianPhoneNumber(String phoneNumber) {
  // Regular expression for the format (123) 456-7890
  final RegExp regex = RegExp(r'^\(\d{3}\) \d{3}-\d{4}$');
  return regex.hasMatch(phoneNumber);
}