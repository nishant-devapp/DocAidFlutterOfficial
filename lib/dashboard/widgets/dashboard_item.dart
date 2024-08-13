import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../home/models/home_get_model.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({super.key, required this.schedule});

  final DocIntr schedule;

  @override
  Widget build(BuildContext context) {
    final startTime = _parseTime(schedule.startTime ?? '00:00:00');
    final endTime = _parseTime(schedule.endTime ?? '00:00:00');
    final duration = endTime.difference(startTime);

    // Calculate height based on duration (e.g., 10 minutes = 10 pixels)
    final cardHeight = duration.inMinutes.toDouble();
    final startHour = startTime.hour;
    final startMinute = startTime.minute;

    print('Building DashboardItem with clinicName: ${schedule.clinicName}, startTime: ${schedule.startTime}, endTime: ${schedule.endTime}');


    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time Slots on the left
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(24, (index) {
              return Container(
                height: 60,
                alignment: Alignment.centerLeft,
                child: Text('${index.toString().padLeft(2, '0')}:00'),
              );
            }),
          ),
          // Schedule Card on the right
          const SizedBox(width: 20.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: (startHour * 60 + startMinute).toDouble()), // Position according to start time
              child: Card(
                color: Colors.lightBlueAccent,
                child: Container(
                  height: cardHeight > 0 ? cardHeight : 60.0, // Dynamic height based on duration
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schedule.clinicName ?? 'No location',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('Purpose: ${schedule.purpose ?? 'No Purpose'}'),
                      Text('Start Time: ${schedule.startTime ?? 'N/A'}'),
                      Text('End Time: ${schedule.endTime ?? 'N/A'}'),
                    ],
                  ),
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
          child: Text('$i:00'),
        ),
      );
    }
    return Column(children: slots);
  }
}
