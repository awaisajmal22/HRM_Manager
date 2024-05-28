import 'package:intl/intl.dart';

String dateFormater(String date) {
  print("Date is $date");
  if (date.isEmpty || date == 'null' || date == null || date == '') {
    return '';
  } else {
    final year = DateFormat.LLL().format(DateTime.parse(date));
    final month = DateFormat.d().format(DateTime.parse(date));
    final day = DateFormat.y().format(DateTime.parse(date));
    final dateTime = '$year $month, $day';
    return dateTime;
  }
}
