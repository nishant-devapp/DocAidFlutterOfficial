import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ClinicItem extends StatefulWidget {
  const ClinicItem({super.key});

  @override
  State<ClinicItem> createState() => _ClinicItemState();
}

class _ClinicItemState extends State<ClinicItem> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1, itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            elevation: 5,
            shadowColor: AppColors.princetonOrange.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Inspire's Eyes'", style: TextStyle(color: AppColors.princetonOrange, fontWeight: FontWeight.w500),),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: AppColors.vermilion, size: 20.0,),
                        const SizedBox(width: 5.0,),
                        Text('Gardanibagh'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
    });
  }
}
