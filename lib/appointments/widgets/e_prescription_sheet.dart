import 'package:code/appointments/utils/advice_list.dart';
import 'package:code/appointments/utils/complaints_list.dart';
import 'package:code/appointments/utils/diagnosis_list.dart';
import 'package:code/appointments/utils/test_list.dart';
import 'package:code/utils/TestScreen.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';
import '../models/fetch_appointment_model.dart';

class EPrescriptionSheet extends StatefulWidget {
  const EPrescriptionSheet({super.key, required this.appointment});

  final AppointmentData appointment;

  @override
  State<EPrescriptionSheet> createState() => _EPrescriptionSheetState();
}

class _EPrescriptionSheetState extends State<EPrescriptionSheet> {
  final TextEditingController _complaintsController = TextEditingController();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _testsController = TextEditingController();
  final TextEditingController _adviceController = TextEditingController();

  final FocusNode _complaintsFocusNode = FocusNode();
  final FocusNode _diagnosisFocusNode = FocusNode();
  final FocusNode _testsFocusNode = FocusNode();
  final FocusNode _adviceFocusNode = FocusNode();

  List<String> filteredComplaints = [];
  List<String> selectedComplaints = [];

  List<String> filteredDiagnosis = [];
  List<String> selectedDiagnosis = [];

  List<String> filteredTests = [];
  List<String> selectedTests = [];

  List<String> filteredAdvices = [];
  List<String> selectedAdvices = [];

  @override
  void initState() {
    super.initState();
    _complaintsController.addListener(_filterComplaints);
    _diagnosisController.addListener(_filterDiagnosis);
    _testsController.addListener(_filterTests);
    _adviceController.addListener(_filterAdvice);
  }

  // For Complaints
  void _filterComplaints() {
    String input = _complaintsController.text.toLowerCase();
    setState(() {
      filteredComplaints = allComplaints
          .where((item) => item.toLowerCase().contains(input))
          .toList();
    });
  }

  void _addSelectedComplain(String item) {
    if (!selectedComplaints.contains(item)) {
      setState(() {
        selectedComplaints.add(item);
        _complaintsController.clear();
        filteredComplaints.clear();
      });
    }
  }

  void _removeSelectedComplain(String item) {
    setState(() {
      selectedComplaints.remove(item);
    });
  }

  // For Diagnosis
  void _filterDiagnosis() {
    String input = _diagnosisController.text.toLowerCase();
    setState(() {
      filteredDiagnosis = allDiagnosis
          .where((item) => item.toLowerCase().contains(input))
          .toList();
    });
  }

  void _addSelectedDiagnosis(String item) {
    if (!selectedDiagnosis.contains(item)) {
      setState(() {
        selectedDiagnosis.add(item);
        _diagnosisController.clear();
        filteredDiagnosis.clear();
      });
    }
  }

  void _removeSelectedDiagnosis(String item) {
    setState(() {
      selectedDiagnosis.remove(item);
    });
  }

  // For Tests
  void _filterTests() {
    String input = _testsController.text.toLowerCase();
    setState(() {
      filteredTests = allTests
          .where((item) => item.toLowerCase().contains(input))
          .toList();
    });
  }

  void _addSelectedTests(String item) {
    if (!selectedTests.contains(item)) {
      setState(() {
        selectedTests.add(item);
        _testsController.clear();
        filteredTests.clear();
      });
    }
  }

  void _removeSelectedTests(String item) {
    setState(() {
      selectedTests.remove(item);
    });
  }

  // For Advice
  void _filterAdvice() {
    String input = _adviceController.text.toLowerCase();
    setState(() {
      filteredAdvices = allAdvices
          .where((item) => item.toLowerCase().contains(input))
          .toList();
    });
  }

  void _addSelectedAdvice(String item) {
    if (!selectedAdvices.contains(item)) {
      setState(() {
        selectedAdvices.add(item);
        _adviceController.clear();
        filteredAdvices.clear();
      });
    }
  }

  void _removeSelectedAdvice(String item) {
    setState(() {
      selectedAdvices.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(builder: (HomeGetProvider homeProvider) {
      final doctorProfile = homeProvider.doctorProfile!;
      final speciality =
          homeProvider.doctorProfile!.data!.specialization!.first;

      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svg/medical_symbol.svg',
                    height: 60,
                    width: 60,
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${doctorProfile.data!.firstName!} ${doctorProfile.data!.lastName!}",
                        style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        doctorProfile.data!.degree!.first,
                        style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        doctorProfile.data!.specialization!.first,
                        style: const TextStyle(
                            color: AppColors.textColor,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/location_icon.svg',
                        width: 15.0,
                        height: 15.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        widget.appointment.clinicLocation ?? 'N/A',
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor),
                      ),
                    ],
                  )),
                  Expanded(
                      child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/call_icon.svg',
                        width: 15.0,
                        height: 15.0,
                      ),
                      const SizedBox(
                        width: 6.0,
                      ),
                      Text(
                        widget.appointment.contact ?? 'N/A',
                        style: const TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textColor),
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/email_icon.svg',
                    width: 10.0,
                    height: 10.0,
                  ),
                  const SizedBox(
                    width: 6.0,
                  ),
                  Text(
                    doctorProfile.data!.email ?? 'N/A',
                    style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 12.0,
              ),
              Card(
                elevation: 2.0,
                shadowColor: AppColors.verdigris.withValues(alpha: 0.8),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Vitals',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: [
                          const Text('BP'),
                          const SizedBox(width: 5.0),
                          Container(
                            width: 42, // Adjust the size as needed
                            height: 42,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black), // Border color
                              borderRadius: BorderRadius.circular(5),  // Rounded corners
                            ),
                            child: const TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none, // Remove default border
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          const Text('/', style: TextStyle(fontSize: 25.0),),
                          const SizedBox(width: 4.0),
                          Container(
                            width: 42, // Adjust the size as needed
                            height: 42,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black), // Border color
                              borderRadius: BorderRadius.circular(5),  // Rounded corners
                            ),
                            child: const TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none, // Remove default border
                                contentPadding: EdgeInsets.all(10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          const Text('mmHg'),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text('TEMP'),
                                const SizedBox(width: 5.0),
                                Container(
                                  width: 42, // Adjust the size as needed
                                  height: 42,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black), // Border color
                                    borderRadius: BorderRadius.circular(5),  // Rounded corners
                                  ),
                                  child: const TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // Remove default border
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const Text('F'),
                            
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Text('SPO2'),
                                const SizedBox(width: 5.0),
                                Container(
                                  width: 42, // Adjust the size as needed
                                  height: 42,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black), // Border color
                                    borderRadius: BorderRadius.circular(5),  // Rounded corners
                                  ),
                                  child: const TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // Remove default border
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const Text('%'),
                            
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text('HEIGHT'),
                                const SizedBox(width: 5.0),
                                Container(
                                  width: 42, // Adjust the size as needed
                                  height: 42,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black), // Border color
                                    borderRadius: BorderRadius.circular(5),  // Rounded corners
                                  ),
                                  child: const TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // Remove default border
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const Text('cm'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Text('WEIGHT'),
                                const SizedBox(width: 5.0),
                                Container(
                                  width: 42, // Adjust the size as needed
                                  height: 42,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black), // Border color
                                    borderRadius: BorderRadius.circular(5),  // Rounded corners
                                  ),
                                  child: const TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // Remove default border
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const Text('KG'),
                            
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text('BMI'),
                                const SizedBox(width: 5.0),
                                Container(
                                  width: 42, // Adjust the size as needed
                                  height: 42,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black), // Border color
                                    borderRadius: BorderRadius.circular(5),  // Rounded corners
                                  ),
                                  child: const TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // Remove default border
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                const Text('PULSE'),
                                const SizedBox(width: 5.0),
                                Container(
                                  width: 42, // Adjust the size as needed
                                  height: 42,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black), // Border color
                                    borderRadius: BorderRadius.circular(5),  // Rounded corners
                                  ),
                                  child: const TextField(
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none, // Remove default border
                                      contentPadding: EdgeInsets.all(10),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.0),
                                const Text('bpm'),

                              ],
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              // Complaints Card
              Card(
                elevation: 2.0,
                shadowColor: AppColors.verdigris.withValues(alpha: 0.8),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Complaints',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      ),
                      Wrap(
                        spacing: 8,
                        children: selectedComplaints.map((item) {
                          return Chip(
                            label: Text(item),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => _removeSelectedComplain(item),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      // Auto-suggestion text field
                       TextField(
                        controller: _complaintsController,
                        focusNode: _complaintsFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Type here...",
                        ),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            _addSelectedComplain(text);
                          }
                        },
                      ),
                      // Dropdown for suggestions
                      if (filteredComplaints.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: filteredComplaints.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () => _addSelectedComplain(item),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              // Diagnosis Card
              Card(
                elevation: 2.0,
                shadowColor: AppColors.verdigris.withValues(alpha: 0.8),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Diagnosis',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      ),
                      Wrap(
                        spacing: 8,
                        children: selectedDiagnosis.map((item) {
                          return Chip(
                            label: Text(item),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => _removeSelectedDiagnosis(item),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      // Auto-suggestion text field
                      TextField(
                        controller: _diagnosisController,
                        focusNode: _diagnosisFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Type here...",
                        ),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            _addSelectedDiagnosis(text);
                          }
                        },
                      ),
                      // Dropdown for suggestions
                      if (filteredDiagnosis.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: filteredDiagnosis.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () => _addSelectedDiagnosis(item),
                              );
                            }).toList(),
                          ),
                        ),

                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              // Tests Card
              Card(
                elevation: 2.0,
                shadowColor: AppColors.verdigris.withValues(alpha: 0.8),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Test Required',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      ),
                      Wrap(
                        spacing: 8,
                        children: selectedTests.map((item) {
                          return Chip(
                            label: Text(item),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => _removeSelectedTests(item),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      // Auto-suggestion text field
                      TextField(
                        controller: _testsController,
                        focusNode: _testsFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Type here...",
                        ),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            _addSelectedTests(text);
                          }
                        },
                      ),
                      // Dropdown for suggestions
                      if (filteredTests.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: filteredTests.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () => _addSelectedTests(item),
                              );
                            }).toList(),
                          ),
                        ),

                    ],
                  ),
                ),
              ),
             // Advice Card
              Card(
                elevation: 2.0,
                shadowColor: AppColors.verdigris.withValues(alpha: 0.8),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Advice',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0),
                      ),
                      Wrap(
                        spacing: 8,
                        children: selectedAdvices.map((item) {
                          return Chip(
                            label: Text(item),
                            deleteIcon: const Icon(Icons.close),
                            onDeleted: () => _removeSelectedAdvice(item),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 8),
                      // Auto-suggestion text field
                      TextField(
                        controller: _adviceController,
                        focusNode: _adviceFocusNode,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Type here...",
                        ),
                        onSubmitted: (text) {
                          if (text.isNotEmpty) {
                            _addSelectedAdvice(text);
                          }
                        },
                      ),
                      // Dropdown for suggestions
                      if (filteredAdvices.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: filteredAdvices.map((item) {
                              return ListTile(
                                title: Text(item),
                                onTap: () => _addSelectedAdvice(item),
                              );
                            }).toList(),
                          ),
                        ),

                    ],
                  ),
                ),
              ),
              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Testscreen()));
              }, icon: Icon(Icons.arrow_circle_right_rounded, size: 50.0,)),
            ],
          ),
        ),
      );
    });
  }
}
