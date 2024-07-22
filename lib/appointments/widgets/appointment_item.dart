import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class AppointmentItem extends StatefulWidget {
  const AppointmentItem({super.key});

  @override
  State<AppointmentItem> createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  List patientNames = [
    "Niraj",
    "Raju Phrontend",
    "Sameer Backhend",
    "Nishant Phlutter"
  ];
  List patientPhones = ["8965895785", "9857485698", "6209857859", "8598785966"];
  List appointmentTime = ["10:30 AM", "11:25 AM", "14:30 PM", "16:45 PM"];
  List paidStatus = ["Unpaid", "Paid", "Paid", "Unpaid"];
  List isVisited = [false, true, true, false];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: patientNames.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 5.0,
              shadowColor: AppColors.verdigris.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              margin:
                  const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(paidStatus[index],
                            style: const TextStyle(
                                color: AppColors.verdigris,
                                fontSize: 18,
                                fontWeight: FontWeight.w400)),
                        const Icon(
                          Icons.edit,
                          color: AppColors.jet,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(patientNames[index],
                        style: const TextStyle(
                            color: AppColors.textColor,
                            wordSpacing: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8.0),
                    Text('Ph. No: ${patientPhones[index]}',
                        style: const TextStyle(
                            color: AppColors.textColor,
                            wordSpacing: 1,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(appointmentTime[index],
                            style: const TextStyle(
                                color: AppColors.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'Visited: ',
                                style: TextStyle(fontSize: 17.0),
                              ),
                              Checkbox(
                                checkColor: Colors.white,
                                activeColor: AppColors.verdigris,
                                value: isVisited[index],
                                onChanged: (value) {
                                  setState(() {
                                    isVisited = value as List;
                                  });
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
