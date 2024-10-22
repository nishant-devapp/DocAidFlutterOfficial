import 'package:code/home/models/home_get_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';

class WeeklyIncomeChart extends StatelessWidget {
  final Map<String, Map<String, double>> weeklyIncome; // Adjusted to hold both income and appointments
  final List<ClinicDtos> clinics;

  const WeeklyIncomeChart(this.weeklyIncome, this.clinics, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: BarChart(
            BarChartData(
              barGroups: _buildBarGroups(),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: _getLeftTitles,
                    reservedSize: 40,
                    interval: 500, // range on the Y-axis
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: _getBottomTitles,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    // Get the current day of the week
                    List<String> daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                    String day = daysOfWeek[groupIndex]; // Fetch the corresponding day

                    // Match clinic ID and get clinic name
                    String clinicId = weeklyIncome.keys.elementAt(rodIndex);
                    String? clinicLocation = _getClinicLocationById(clinicId);

                    double income = rod.toY;

                    // Return tooltip item with day, clinic name, amount, and total appointments
                    return BarTooltipItem(
                      "$day\nClinic: $clinicLocation\nAmount: \u20B9${income.toStringAsFixed(0)}", // Show day, clinic name, amount, and total appointments
                      const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20), // Add spacing between the chart and legend
        // The Legend
        _buildLegend(),
      ],
    );
  }

  // Build bar groups for each day and clinic
  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];

    List<String> daysOfWeek = ["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"];

    for (int i = 0; i < daysOfWeek.length; i++) {
      final String day = daysOfWeek[i];

      List<BarChartRodData> rods = [];
      int clinicIndex = 0;

      // For each clinic, create a bar for the current day
      weeklyIncome.forEach((clinicId, income) {
        rods.add(
          BarChartRodData(
            toY: income[day] ?? 0.0, // Update to get totalAmount for each bar
            width: 3, // Width of each bar
            color: _getClinicColor(clinicIndex), // Assign a color from AppColors
          ),
        );
        clinicIndex++;
      });

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: rods,
          barsSpace: 1, // Space between bars for the same day
        ),
      );
    }

    return barGroups;
  }

  // Find the clinic name by matching the clinicId
  String? _getClinicLocationById(String clinicId) {
    final clinic = clinics.firstWhere(
          (clinic) => clinic.id.toString() == clinicId,
    );
    return clinic.location;
  }

  // Assign custom colors to the clinic bars
  Color _getClinicColor(int index) {
    List<Color> colors = [
      AppColors.graphColor1,
      AppColors.graphColor2,
      AppColors.graphColor3,
      AppColors.graphColor4,
    ];
    return colors[index % colors.length];
  }

  // Customize the bottom titles for days of the week
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

  // Customize the left titles to avoid overlapping
  Widget _getLeftTitles(double value, TitleMeta meta) {
    if (value == 0) return Container();
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        value.toStringAsFixed(0), // Format the number
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  // Build the legend below the chart
  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Wrap(
        alignment: WrapAlignment.center, // Center the legend items
        spacing: 20, // Add spacing between items
        children: List.generate(clinics.length, (index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                color: _getClinicColor(index), // Use the same color as the clinic bar
              ),
              SizedBox(width: 5),
              Text(
                clinics[index].location ?? '', // Use clinic name
                style: TextStyle(fontSize: 12),
              ),
            ],
          );
        }),
      ),
    );
  }
}

