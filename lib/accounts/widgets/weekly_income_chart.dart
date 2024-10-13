import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyIncomeChart extends StatelessWidget {
  final Map<String, Map<String, double>> weeklyIncome; // Income data for each clinic

  WeeklyIncomeChart(this.weeklyIncome);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: _buildBarGroups(),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, getTitlesWidget: _getBottomTitles),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];

    List<String> daysOfWeek = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];

    // Loop through each day of the week
    for (int i = 0; i < daysOfWeek.length; i++) {
      final String day = daysOfWeek[i];

      List<BarChartRodData> rods = [];

      // For each clinic, create a bar for the current day
      int clinicIndex = 0;
      weeklyIncome.forEach((clinicId, income) {
        rods.add(
          BarChartRodData(
            toY: income[day] ?? 0, // Get income for the day for this clinic
            width: 15, // Width of each bar
            color: _getClinicColor(clinicIndex), // Assign a color per clinic
          ),
        );
        clinicIndex++;
      });

      // Add the group of bars for the current day
      barGroups.add(BarChartGroupData(
        x: i,
        barRods: rods,
        barsSpace: 4, // Space between bars
      ));
    }

    return barGroups;
  }

  Color _getClinicColor(int index) {
    // You can define different colors for each clinic here
    List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.orange];
    return colors[index % colors.length];
  }

  Widget _getBottomTitles(double value, TitleMeta meta) {
    const days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        days[value.toInt()],
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}

