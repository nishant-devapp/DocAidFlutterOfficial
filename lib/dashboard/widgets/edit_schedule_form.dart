import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../home/models/home_get_model.dart';
import '../../home/provider/home_provider.dart';
import '../../utils/constants/colors.dart';

class EditScheduleForm extends StatefulWidget {
  const EditScheduleForm({super.key, required this.schedule});

  final DocIntr? schedule;

  @override
  State<EditScheduleForm> createState() => _EditScheduleFormState();
}

class _EditScheduleFormState extends State<EditScheduleForm> {
  final _key = GlobalKey<FormState>();
  bool _isUpdating = false;
  bool _isDeleting = false;

  TextEditingController _purposeController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');
  final DateFormat _timeFormatter = DateFormat('hh:mm:ss');

  @override
  void initState() {
    super.initState();

    if (widget.schedule != null) {
      _purposeController.text = widget.schedule!.purpose ?? '';
      _locationController.text = widget.schedule!.clinicName ?? '';
      _startDateController.text = widget.schedule!.stDate ?? '';
      _endDateController.text = widget.schedule!.endDate ?? '';
      _startTimeController.text = widget.schedule!.startTime ?? '';
      _endTimeController.text = widget.schedule!.endTime ?? '';

      // Convert existing date strings to DateTime objects
      _selectedStartDate = widget.schedule!.stDate != null
          ? _dateFormatter.parse(widget.schedule!.stDate!)
          : null;
      _selectedEndDate = widget.schedule!.endDate != null
          ? _dateFormatter.parse(widget.schedule!.endDate!)
          : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return DoctorProfileBase(builder: (HomeGetProvider homeProvider){
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: deviceHeight * 0.01,
          horizontal: deviceWidth * 0.03,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(height: deviceHeight * 0.02),
                Text(
                  'Edit Schedule',
                  style: TextStyle(
                    fontSize: deviceHeight * 0.028,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: deviceHeight * 0.03),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _purposeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: const Text('Purpose'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter purpose';
                    }
                    return null;
                  },
                ),
                SizedBox(height: deviceHeight * 0.02),
                TextFormField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _locationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    label: const Text('Location'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: deviceHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: _startTimeController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: const Text('Start Time'),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: AppColors.princetonOrange,
                            ),
                            onPressed: _selectStartTime,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter start time';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: deviceWidth * 0.04),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: _endTimeController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: const Text('End Time'),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: AppColors.princetonOrange,
                            ),
                            onPressed: _selectEndTime,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter end time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceHeight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: _startDateController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: const Text('Start Date'),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: AppColors.verdigris,
                            ),
                            onPressed: () => _selectDate(context, true),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter start date';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: deviceWidth * 0.04),
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: _endDateController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: const Text('End Date'),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Icons.access_time_outlined,
                              color: AppColors.verdigris,
                            ),
                            onPressed: () => _selectDate(context, false),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter end date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: deviceHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed:  _isDeleting ? null :() async{
                          setState(() {
                            _isDeleting = true;
                          });

                          await homeProvider.deleteSchedule(widget.schedule!.id!);

                          Navigator.pop(context);

                          setState(() {
                            _isDeleting = false;
                          });
                        },
                        icon: _isDeleting
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        )
                            : const Icon(Icons.delete, color: Colors.white),
                        label: Text(
                          _isDeleting ? "Deleting..." : "Delete",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 2.0,
                          backgroundColor: AppColors.vermilion,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0,),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isUpdating ? null :() async {
                          if (!_key.currentState!.validate()) {
                            return;
                          }
                          // Print form values for debugging
                         /* print(_purposeController.text.trim());
                          print(_locationController.text.trim());
                          print('Start Time: ${_startTimeController.text.trim()}');
                          print('End Time: ${_endTimeController.text.trim()}');
                          print('Start Date: ${_startDateController.text.trim()}');
                          print('End Date: ${_endDateController.text.trim()}');*/

                          setState(() {
                            _isUpdating = true;
                          });

                          await homeProvider.updateDoctorSchedule(
                            widget.schedule!.id!,
                              _startTimeController.text.trim(),
                              _endTimeController.text.trim(),
                              _locationController.text.trim(),
                              _purposeController.text.trim(),
                              _startDateController.text.trim(),
                              _endDateController.text.trim());

                          Navigator.pop(context);

                          setState(() {
                            _isUpdating = false;
                          });
                        },
                        icon: _isUpdating
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.0,
                        )
                            : const Icon(Icons.edit_calendar, color: Colors.white),
                        label: Text(
                          _isUpdating ? "Updating..." : "Edit",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 2.0,
                          backgroundColor: AppColors.verdigris,
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });


  }

  void _deleteSchedule() {
    // Implement deletion logic here
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = _convertTo24HourFormat(selectedTime);
      setState(() {
        _startTimeController.text = formattedTime;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      final String formattedTime = _convertTo24HourFormat(selectedTime);
      setState(() {
        _endTimeController.text = formattedTime;
      });
    }
  }


  String _convertTo24HourFormat(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final DateTime dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final DateFormat outputFormat = DateFormat('HH:mm:ss');
    return outputFormat.format(dateTime);
  }



  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final formattedDate = _dateFormatter.format(selectedDate);

      if (isStartDate) {
        setState(() {
          _selectedStartDate = selectedDate;
          _startDateController.text = formattedDate;
        });
      } else {
        setState(() {
          _selectedEndDate = selectedDate;
          _endDateController.text = formattedDate;
        });
      }
    }
  }
}
