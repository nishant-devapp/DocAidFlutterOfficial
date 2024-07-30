import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../constants/colors.dart';

void showToast(BuildContext context, String message, Color color, Color txtColor) {
  toastification.showCustom(
    context: context,
    autoCloseDuration: const Duration(seconds: 3),
    alignment: Alignment.bottomCenter,
    builder: (BuildContext context, ToastificationItem holder) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: color,
          ),
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(8),
          child: Text(message,
              style: TextStyle(color: txtColor)),
        ),
      );
    },
  );
}

// Below is how to use it ⬇
// showToast(context, "Add Appointment Pressed!!");
