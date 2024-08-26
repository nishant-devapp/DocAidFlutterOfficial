import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClinicChargeDialog extends StatelessWidget {
  const ClinicChargeDialog(
      {super.key,
      required this.title,
      required this.description,
      required this.onCancel,
      required this.onAccept});

  final String title, description;
  final VoidCallback onCancel, onAccept;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: Colors.white,
      elevation: 2.0,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: AppColors.almond,
                child: ClipOval(
                  child: SvgPicture.asset(
                    "assets/svg/tick.svg",
                    height: 18.0,
                    width: 18.0,
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                      fontSize: 18.0
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 15.0,
          // ),
          Text(
            description,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.textColor,
                fontSize: 15.0),
          ),
          // const SizedBox(
          //   height: 25.0,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: onCancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.dashboardColor,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500),
                  )),
              const SizedBox(
                width: 20.0,
              ),
              ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.verdigris,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Accept',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
