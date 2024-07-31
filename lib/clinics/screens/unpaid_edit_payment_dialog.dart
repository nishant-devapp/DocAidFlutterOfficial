import 'package:flutter/material.dart';

class UnpaidEditPaymentDialog extends StatefulWidget {
  const UnpaidEditPaymentDialog({super.key, required this.appointmentId});

  final int appointmentId;

  @override
  State<UnpaidEditPaymentDialog> createState() => _UnpaidEditPaymentDialogState();
}

class _UnpaidEditPaymentDialogState extends State<UnpaidEditPaymentDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      elevation: 2.0,
    );
  }
}
