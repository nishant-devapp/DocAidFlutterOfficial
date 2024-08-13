import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../home/models/home_get_model.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({super.key, required this.schedule});

  final DocIntr schedule;

  @override
  Widget build(BuildContext context) {
    final startTime = _parseTime(schedule.startTime!);
    final endTime = _parseTime(schedule.endTime!);
    final duration = endTime.difference(startTime);

    // Calculate height based on duration (e.g., 10 minutes = 10 pixels)
    final cardHeight = duration.inMinutes.toDouble();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: _buildTimeSlots(),
          ),
          Positioned(
            left: 60, // Space for time slots
            child: Card(
              color: Colors.lightBlueAccent,
              child: Container(
                height: cardHeight, // Dynamic height based on duration
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${schedule.clinicName}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('Purpose: ${schedule.purpose}'),
                    Text('Start Time: ${schedule.startTime}'),
                    Text('End Time: ${schedule.endTime}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DateTime _parseTime(String time) {
    return DateFormat.Hms().parse(time);
  }

  // Build time slots on the left side
  Widget _buildTimeSlots() {
    List<Widget> slots = [];
    for (int i = 0; i <= 24; i++) {
      slots.add(
        Container(
          height: 60,
          alignment: Alignment.centerLeft,
          child: Text('${i}:00'),
        ),
      );
    }
    return Column(children: slots);
  }
}
