import 'package:code/appointments/providers/appointment_provider.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnpaidEditPaymentDialog extends StatefulWidget {
  const UnpaidEditPaymentDialog({super.key, required this.appointmentId});

  final int appointmentId;

  @override
  State<UnpaidEditPaymentDialog> createState() =>
      _UnpaidEditPaymentDialogState();
}

class _UnpaidEditPaymentDialogState extends State<UnpaidEditPaymentDialog> {
  String _selectedMethod = 'UPI'; // Initial selected option

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Select Payment Option',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close_rounded,
                          color: AppColors.princetonOrange, size: 30.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                // controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Fees',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('UPI'),
                      value: 'UPI',
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Cash'),
                      value: 'Cash',
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await appointmentProvider.unpayAppointment(widget.appointmentId);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, deviceHeight * 0.06),
                        backgroundColor: AppColors.vermilion,
                      ),
                      child: const Text(
                        'Unpaid',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, deviceHeight * 0.06),
                        backgroundColor: AppColors.verdigris,
                      ),
                      child: const Text(
                        'Edit Payment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      );
    });
  }
}
