import 'dart:math';

import 'package:code/dashboard/widgets/add_schedule_form.dart';
import 'package:code/dashboard/widgets/dashboard_item.dart';
import 'package:code/dashboard/widgets/edit_schedule_form.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../home/models/home_get_model.dart';
import '../../home/provider/home_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<HomeGetProvider>(context, listen: false);
      if (provider.doctorProfile == null) {
        provider.fetchDoctorProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;

    return Scaffold(
      body: Consumer<HomeGetProvider>(
        builder: (context, homeProvider, child) {
          if (homeProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final doctorIntr = homeProvider.doctorProfile?.data?.docIntr ?? [];
          final todaySchedules = doctorIntr.where((intr) {
            return DateFormat('yyyy-MM-dd').format(selectedDate) == intr.stDate;
          }).toList();

          if (todaySchedules.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Welcome', style: TextStyle(fontSize: 18.0, color: AppColors.textColor, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 5.0),
                          Text(homeProvider.doctorProfile!.data!.firstName!, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.verdigris, fontSize: 22.0),),
                        ],),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('d MMM, yyyy').format(selectedDate),
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(icon: const Icon(Icons.keyboard_arrow_left_rounded,size: 30.0),  onPressed: () {
                                setState(() {
                                  selectedDate = selectedDate.subtract(const Duration(days: 1));
                                });},),

                              IconButton(icon: const Icon(Icons.circle_outlined,size: 25.0),  onPressed: () {setState(() {
                                selectedDate = DateTime.now();
                              });},),

                              IconButton(icon: const Icon(Icons.keyboard_arrow_right_rounded,size: 30.0),  onPressed: () {setState(() {
                                selectedDate = selectedDate.add(const Duration(days: 1));
                              });},),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  // Text(homeProvider.doctorProfile!.data!.firstName!, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.verdigris, fontSize: 25.0),),
                  const Spacer(),
                  Center(child: Lottie.asset('assets/lottie/no_schedule_lottie.json', repeat: true)),
                  const Spacer()
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      const Text('Welcome', style: TextStyle(fontSize: 18.0, color: AppColors.textColor, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5.0),
                      Text(homeProvider.doctorProfile!.data!.firstName!, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.verdigris, fontSize: 22.0),),
                    ],),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat('d MMM, yyyy').format(selectedDate),
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(icon: const Icon(Icons.keyboard_arrow_left,size: 30.0),  onPressed: () {
                              setState(() {
                              selectedDate = selectedDate.subtract(const Duration(days: 1));
                            });},),

                            IconButton(icon: const Icon(Icons.circle_outlined,size: 25.0),  onPressed: () {setState(() {
                              selectedDate = DateTime.now();
                            });},),
                            // Text(
                            //   'Today',
                            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.grey[800]),
                            // ),
                            IconButton(icon: const Icon(Icons.keyboard_arrow_right,size: 30.0),  onPressed: () {setState(() {
                              selectedDate = selectedDate.add(const Duration(days: 1));
                            });},),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        _buildTimeSlots(),
                        _buildEventCards(context, todaySchedules),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => DraggableScrollableSheet(
              expand: false,
              builder: (context, scrollController) => SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const AddScheduleForm(),
                ),
              ),
            ),
          );
        },
        backgroundColor: AppColors.verdigris,
        foregroundColor: Colors.white,
        splashColor: AppColors.princetonOrange,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTimeSlots() {
    final times = List.generate(24, (index) => '${index.toString().padLeft(2, '0')}:00');

    return Column(
      children: times.map((time) {
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 12.0),
              const Expanded(child: Divider()),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildEventCards(BuildContext context, List<DocIntr> schedules) {
    return Positioned.fill(
      child: Stack(
        children: schedules.map((schedule) {
          final startTime = _parseTime(schedule.startTime!);
          final endTime = _parseTime(schedule.endTime!);
          final duration = endTime.difference(startTime);
          final topPosition = _calculateTopPosition(startTime);
          final cardHeight = _calculateCardHeight(duration);

          return Positioned(
            top: topPosition,
            left: 100.0,
            right: 16.0,
            child: GestureDetector(
              onTap: () => _onEventTap(context, schedule),
              child: Container(
                height: cardHeight,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Card(
                  elevation: 4.0,
                  color: _generateRandomColor(),
                  shadowColor: AppColors.mistyRose,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          schedule.clinicName!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text('${DateFormat('HH:mm').format(startTime)} - ${DateFormat('HH:mm').format(endTime)}'),
                        const SizedBox(height: 4.0),
                        Text(schedule.purpose!),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }


  double _calculateTopPosition(DateTime time) {
    return (time.hour * 60 + time.minute) * 1.0;
  }

  double _calculateCardHeight(Duration duration) {
    const double minutesPerPixel = 1.0; // Adjust this value as needed
    return duration.inMinutes * minutesPerPixel;
  }


  DateTime _parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(0, 0, 0, hour, minute);
  }

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      200 + random.nextInt(56),
      200 + random.nextInt(56),
      200 + random.nextInt(56),
      1.0,
    );
  }

  void _onEventTap(BuildContext context, DocIntr schedule) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: EditScheduleForm(schedule: schedule),
            ),
          );
        },
      ),
    );
  }

}
