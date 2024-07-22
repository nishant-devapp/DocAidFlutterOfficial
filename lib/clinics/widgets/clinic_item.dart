import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ClinicItem extends StatefulWidget {
  const ClinicItem({super.key});

  @override
  State<ClinicItem> createState() => _ClinicItemState();
}

class _ClinicItemState extends State<ClinicItem> {
  List clinicsNames = ["Health Point Clinic", "Apex Clinic", "Wellness Clinic"];

  List clinicLocation = ['Patliputra', 'Boring Road', 'Kankarbagh'];

  List compounders = ["Ashoka Sharma", "Dheeraj Kumar", "Manish Anand"];

  List phoneNumbers = ['8525203620', '8541203610', '8796412321'];

  List visitingNewFees = ['1000', '800', '800'];
  List visitingOldFees = ['800', '600', '750'];

  List time = ['10:00 - 12:00', '12:30 - 16:00', '17:00 - 21:00'];

  List days = ['M W F', 'T Th Sa', 'M F S'];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: clinicsNames.length,
        itemBuilder: (context, index) {
          return Card(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin:
                const EdgeInsets.only(bottom: 30.0, left: 10.0, right: 10.0),
            elevation: 10,
            shadowColor: AppColors.verdigris.withOpacity(0.4),
            child: Container(
              // color: Colors.white,
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(clinicsNames[index],
                          style: const TextStyle(
                              fontSize: 22,
                              color: AppColors.princetonOrange,
                              fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: AppColors.vermilion,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            clinicLocation[index],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Visiting New Patient Fees',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold)),
                      Text(
                        'Rs. ${visitingNewFees[index]}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Visiting Old Patient Fees',
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.textColor,
                              fontWeight: FontWeight.bold)),
                      Text(
                        'Rs. ${visitingOldFees[index]}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Compounder: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        compounders[index],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Phone No.: ",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        phoneNumbers[index],
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Time: ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textColor),
                          ),
                          const SizedBox(
                            width: 3.0,
                          ),
                          Text(
                            time[index],
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Text(
                        days[index],
                        style:
                            const TextStyle(fontSize: 18, color: AppColors.vermilion, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Add onPressed logic for the first button
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          backgroundColor: AppColors.lightGrey,
                          // Color of the first button
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Curvature of 10px
                          ),
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16), // Text color
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            // Add onPressed logic for the second button
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15.0),
                            backgroundColor: AppColors.verdigris,
                            // Color of the second button
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Curvature of 10px
                            ),
                          ),
                          child: const Text(
                            'Check Appointments',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16), // Text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
