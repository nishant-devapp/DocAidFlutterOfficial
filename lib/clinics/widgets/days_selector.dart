import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DaysSelector extends StatefulWidget {
  const DaysSelector({super.key, required this.onSelectionChanged, required this.selectedDays});

  final Function(List<String>) onSelectionChanged;
  final List<String> selectedDays;

  @override
  State<DaysSelector> createState() => _DaysSelectorState();
}

class _DaysSelectorState extends State<DaysSelector> {

  final List<String> _weekDays = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];
  late List<String> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    _selectedDays = widget.selectedDays; // Initialize with pre-selected days
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: _weekDays.map((day) {
        final bool isSelected = _selectedDays.contains(day);
        return ChoiceChip(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          label: Text(
            day,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
          selected: isSelected,
          selectedColor: AppColors.princetonOrange,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedDays.add(day);
              } else {
                _selectedDays.remove(day);
              }
              _selectedDays.sort((a, b) => _weekDays.indexOf(a).compareTo(_weekDays.indexOf(b)));
              widget.onSelectionChanged(List.from(_selectedDays));
            });
          },
        );
      }).toList(),
    );
  }
}
