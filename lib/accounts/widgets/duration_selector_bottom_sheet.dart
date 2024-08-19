import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DurationSelectorBottomSheet extends StatefulWidget {
  const DurationSelectorBottomSheet({super.key, required this.onDurationSelected});

  final Function(int) onDurationSelected;

  @override
  State<DurationSelectorBottomSheet> createState() => _DurationSelectorBottomSheetState();
}

class _DurationSelectorBottomSheetState extends State<DurationSelectorBottomSheet> {

  int? _selectedDuration;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Pick Your Perfect Plan',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDurationCard(1, 'Monthly', 'Rs. 1500 + 500/ Additional Clinics', '+18% GST'),
            const SizedBox(height: 5.0),
            _buildDurationCard(3, 'Quarterly', 'Rs. 4500 + 1500/ Additional Clinics', '+18% GST'),
            const SizedBox(height: 5.0),
            _buildDurationCard(6, 'Half Yearly', 'Rs. 9000 + 3000/ Additional Clinics', '+18% GST'),
            const SizedBox(height: 5.0),
            _buildDurationCard(12, 'Yearly', 'Rs. 18000 + 6000/ Additional Clinics', '+18% GST'),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                widget.onDurationSelected(_selectedDuration!);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, deviceHeight * 0.06),
                backgroundColor: AppColors.princetonOrange,
              ),
              child: const Text('Continue', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18.0),),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationCard(int value, String title, String subtitle, String gst) {
    bool isSelected = _selectedDuration == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDuration = value;
        });
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: isSelected ? AppColors.celeste : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: isSelected ? AppColors.princetonOrange : Colors.grey, width: 1),
          ),
          elevation: isSelected ? 6 : 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: AppColors.vermilion,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  gst,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: AppColors.vermilion.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
