import 'package:intl/intl.dart';

String formatTime(String time) {
  // Parse the string to a DateTime object
  DateTime dateTime = DateFormat("HH:mm:ss").parse(time);

  // Format the DateTime object to 12-hour format
  String formattedTime = DateFormat("hh:mm a").format(dateTime);

  return formattedTime;
}
