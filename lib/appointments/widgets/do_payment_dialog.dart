import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/colors.dart';
import '../providers/appointment_provider.dart';

class DoPaymentDialog extends StatefulWidget {
  const DoPaymentDialog({
    super.key,
    required this.appointmentId,
    required this.clinicNewFee,
    required this.clinicOldFee,
    required this.visitStatus,
  });

  final int appointmentId;
  final String clinicNewFee, clinicOldFee, visitStatus;

  @override
  State<DoPaymentDialog> createState() => _DoPaymentDialogState();
}

class _DoPaymentDialogState extends State<DoPaymentDialog> {
  String? _selectedFee; // Initial selected option is null
  final TextEditingController _customFeeController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form key to manage form state

  @override
  void dispose() {
    _customFeeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;

    return Consumer<AppointmentProvider>(
      builder: (context, appointmentProvider, child) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white,
          elevation: 3.0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Form(
              key: _formKey,
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
                  RadioListTile<String>(
                    title: Text('New Patient Fee: Rs.${widget.clinicNewFee}'),
                    value: widget.clinicNewFee,
                    groupValue: _selectedFee,
                    onChanged: (value) {
                      setState(() {
                        _selectedFee = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text('Old Patient Fee: Rs.${widget.clinicOldFee}'),
                    value: widget.clinicOldFee,
                    groupValue: _selectedFee,
                    onChanged: (value) {
                      setState(() {
                        _selectedFee = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Custom Patient Fee'),
                    value: 'Custom',
                    groupValue: _selectedFee,
                    onChanged: (value) {
                      setState(() {
                        _selectedFee = value;
                      });
                    },
                  ),
                  if (_selectedFee == 'Custom')
                    TextFormField(
                      controller: _customFeeController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.currency_rupee),
                        labelText: 'Enter amount',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (_selectedFee == 'Custom' && value!.isEmpty) {
                          return 'Please enter a custom fee amount';
                        }
                        return null;
                      },
                    ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            // _submit('UPI', widget.appointmentId,);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(double.infinity, deviceHeight * 0.06),
                            backgroundColor: AppColors.princetonOrange,
                          ),
                          child: const Text(
                            'UPI',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // _submit('CASH', widget.appointmentId);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize:
                                Size(double.infinity, deviceHeight * 0.06),
                            backgroundColor: AppColors.princetonOrange,
                          ),
                          child: const Text(
                            'Cash',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
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
          ),
        );
      },
    );
  }

  void _submit(String paymentMethod, int appointmentId, String appointmentDate, int clinicId, int doctorId) {
    if (_selectedFee == null) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a fee option.')),
      );
      return;
    }

    if (_selectedFee == 'Custom' && _customFeeController.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a custom fee amount.')),
      );
      return;
    }

    final selectedFee =
        _selectedFee == 'Custom' ? _customFeeController.text : _selectedFee;

    // Print the selected fee (for demonstration purposes)
    // print('Selected Fee: $selectedFee, Payment Method: $paymentMethod');

    // Call the doPayment method of the provider
    final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);


    // Changes to be done below and the submit method

    // appointmentProvider.makeAppointmentPayment(appointmentId, paymentMethod, selectedFee!);

    if (widget.visitStatus == 'NOT_VISITED') {
      appointmentProvider.updateAppointmentVisitStatus(appointmentId, true);
    }

    Navigator.pop(context);
  }
}
