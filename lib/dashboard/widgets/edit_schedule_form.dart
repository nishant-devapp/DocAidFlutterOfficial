import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../home/models/home_get_model.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/Toaster.dart';

class EditScheduleForm extends StatefulWidget {
  const EditScheduleForm({super.key, required this.schedule});

  final DocIntr? schedule;

  @override
  State<EditScheduleForm> createState() => _EditScheduleFormState();
}

class _EditScheduleFormState extends State<EditScheduleForm> {

  final _key = GlobalKey<FormState>();
  bool _isUpdating = false;

  TextEditingController _purposeController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  final List<String> _timeOptions = _generateTimeOptions();

  String? _selectedStartTime;
  String? _selectedEndTime;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  bool _isStartTimeValid = true;
  bool _isEndTimeValid = true;
  bool _isStartDateValid = true;
  bool _isEndDateValid = true;
  // final TextEditingController startTimeController = TextEditingController(
  //   text: DateFormat('HH:mm').format(_parseTime(widget.schedule.startTime!)),
  // );
  // final TextEditingController endTimeController = TextEditingController(
  //   text: DateFormat('HH:mm').format(_parseTime(widget.schedule.endTime!)),
  // );

  @override
  void initState() {
    super.initState();

    if(widget.schedule != null){
      _purposeController.text = widget.schedule!.purpose!;
      _locationController.text = widget.schedule!.clinicName!;

    }

  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

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
              Text('Edit Schedule', style: TextStyle(fontSize: deviceHeight * 0.028, fontWeight: FontWeight.w600),),
              SizedBox(height: deviceHeight * 0.03),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                controller: _purposeController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    label: const Text('Purpose'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    )),
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
                    )),
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
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.03,
                        vertical: deviceHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            // color: _isStartTimeValid
                            //     ? AppColors.princetonOrange
                            //     : Colors.red,
                          color: AppColors.princetonOrange,
                            width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedStartTime,
                          hint: Text('Start Time'),
                          items: _timeOptions.map((String time) {
                            return DropdownMenuItem<String>(
                              value: time,
                              child: Text(time),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedStartTime = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: deviceWidth * 0.04),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.03,
                        vertical: deviceHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                            // color: _isEndTimeValid
                            //     ? AppColors.princetonOrange
                            //     : Colors.red,
                          color: AppColors.princetonOrange,
                            width: 1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedEndTime,
                          hint: const Text('End Time'),
                          items: _timeOptions.map((String time) {
                            return DropdownMenuItem<String>(
                              value: time,
                              child: Text(time),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedEndTime = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, true),
                      child: Container(
                        padding:  EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color:  _isStartDateValid
                              ? AppColors.verdigris
                              : Colors.red,),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            _selectedStartDate == null
                                ? 'Start Date'
                                : DateFormat('yyyy-MM-dd').format(_selectedStartDate!),
                            style: TextStyle(fontSize: deviceHeight * 0.018),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: deviceWidth * 0.04),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context, false),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: _isEndDateValid
                              ? AppColors.verdigris
                              : Colors.red),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: Text(
                            _selectedEndDate == null
                                ? 'End Date'
                                : DateFormat('yyyy-MM-dd').format(_selectedEndDate!),
                            style: TextStyle(fontSize: deviceHeight * 0.018),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: deviceHeight * 0.03),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, deviceHeight * 0.06),
                      backgroundColor: AppColors.verdigris,
                    ),
                    onPressed: _deleteSchedule,
                    child: Text('Delete', style: TextStyle(color: Colors.white, fontSize: deviceHeight * 0.022,),),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, deviceHeight * 0.06),
                      backgroundColor: AppColors.verdigris,
                    ),
                    onPressed: _updateSchedule,
                    child: Text('Edit', style: TextStyle(color: Colors.white, fontSize: deviceHeight * 0.022,),),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );

  }

  void _updateSchedule() async{
    if (!_key.currentState!.validate()) {
      return;
    }

    // setState(() {
    //   _isStartTimeValid = _selectedStartTime != null;
    //   _isEndTimeValid = _selectedEndTime != null;
    //   _isStartDateValid = _selectedStartDate != null;
    //   _isEndDateValid = _selectedEndDate != null;
    // });
    //
    // if (_isStartTimeValid && _isEndTimeValid && _isStartDateValid && _isEndDateValid) {
    //   final finalStartTime = _convertTo24HourFormat(_selectedStartTime!);
    //   final finalEndTime = _convertTo24HourFormat(_selectedEndTime!);
    //
    //   final finalStartDate = DateFormat('yyyy-MM-dd').format(_selectedStartDate!);
    //   final finalEndDate = DateFormat('yyyy-MM-dd').format(_selectedEndDate!);
    //
    //   print(_purposeController.text.trim());
    //   print(_locationController.text.trim());
    //   print('Start Time: $finalStartTime');
    //   print('End Time: $finalEndTime');
    //   print('Start Date: $finalStartDate');
    //   print('End Date: $finalEndDate');
    //
    // } else {
    //   showToast(context, 'Please fill all fields', AppColors.vermilion, Colors.white);
    // }

  }

  void _deleteSchedule() async{}



  static List<String> _generateTimeOptions() {
    final List<String> options = [];
    final timeFormat = DateFormat("h:mm a");
    final now = DateTime.now();
    DateTime currentTime = DateTime(now.year, now.month, now.day, 0, 0);

    for (int i = 0; i < 24 * 60; i += 15) {
      options.add(timeFormat.format(currentTime));
      currentTime = currentTime.add(const Duration(minutes: 15));
    }

    return options;
  }

  String _convertTo24HourFormat(String time) {
    final format = DateFormat('h:mm a');
    final parsedTime = format.parse(time);
    return DateFormat('HH:mm:ss').format(parsedTime);
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );
    if (pickedDate != null && pickedDate != (isStartDate ? _selectedStartDate : _selectedEndDate)) {
      setState(() {
        if (isStartDate) {
          _selectedStartDate = pickedDate;
        } else {
          _selectedEndDate = pickedDate;
        }
      });
    }
  }
}
