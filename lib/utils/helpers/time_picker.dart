import 'package:flutter/material.dart';

Future<String> selectTime(BuildContext context) async {
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime != null) {
    final now = DateTime.now();
    final selectedTime = DateTime(
        now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
    final formattedTime =
        '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00';
    return formattedTime;
  } else {
    return '';
  }
}
