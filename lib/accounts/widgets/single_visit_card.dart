import 'package:flutter/material.dart';
import 'package:code/utils/constants/colors.dart';

class SingleVisitCard extends StatelessWidget {
  const SingleVisitCard({
    Key? key,
    required this.count,
    required this.description,
  }) : super(key: key);

  final String count;
  final String description;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          elevation: 5,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Container(
                width: 10.0,
                decoration: BoxDecoration(
                  color: AppColors.princetonOrange,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(count, style: const TextStyle(color: AppColors.princetonOrange, fontSize: 20.0, fontWeight: FontWeight.w600),),
                    const SizedBox(height: 8.0,),
                    Text(description, style: const TextStyle(color: AppColors.textColor, fontSize: 16.0, fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
