extension NullableNameExtension on String? {

  String  isNotNullableString(){
 if(this == 'null' || this == null ||this!.isEmpty ){
  return '';
 }else{
  return this!;
 }
  }
// String firstAndLastNam(String? firstName, String? lastName){
// if(firstName == null && lastName != null){
//   return lastName;
// }else if(lastName == null && firstName != null){
//   return firstName;
// }else if(firstName == null && lastName == null){
//   return '';
// }else{
//   return '$firstName $lastName';
// }
// }
}