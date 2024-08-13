import 'package:code/dashboard/widgets/add_schedule_form.dart';
import 'package:code/dashboard/widgets/dashboard_item.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../home/models/home_get_model.dart';
import '../../home/provider/home_provider.dart';
import '../../home/widgets/doctor_profile_base.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

// List<DocIntr>? doctorIntr;

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
            return Center(child: CircularProgressIndicator());
          }

          if (homeProvider.doctorProfile == null || homeProvider.doctorProfile!.data == null || homeProvider.doctorProfile!.data!.docIntr == null) {
            return Center(child: Text("No schedules available"));
          }

          final doctorIntr = homeProvider.doctorProfile!.data!.docIntr!;
          if (doctorIntr == null) {
            print('doctorIntr is null');
          } else {
            print('doctorIntr length: ${doctorIntr.length}');
          }
          final todaySchedules = doctorIntr!.where((intr) {
            print('stDate: ${intr.stDate}'); // Add this line
            return DateFormat('yyyy-MM-dd').format(DateTime.now()) == intr.stDate;
          }).toList();

          print('Today\'s schedules: ${todaySchedules.length}');


          if (todaySchedules.isEmpty) {
            return Center(child: Lottie.asset('assets/lottie/no_schedule_lottie.json', repeat: true));
          }

          return ListView.builder(
            itemCount: todaySchedules.length,
            itemBuilder: (context, index) {
              final schedule = todaySchedules[index];
              return DashboardItem(schedule: schedule);
            },
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

}
