import 'package:intl/intl.dart';

String dateFormater(DateTime date){
  final year = DateFormat.y().format(date);
  final month = DateFormat.LLL().format(date);
  final day = DateFormat.d().format(date);
  final dateTime = '$year, $month $day';
  return dateTime;
}