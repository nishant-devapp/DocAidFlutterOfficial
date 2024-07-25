import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../home/provider/home_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

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
    return Scaffold(
      body: Consumer<HomeGetProvider>(builder: (context, homeProvider, child) {
        if (homeProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (homeProvider.errorMessage != null) {
          return Center(child: Text('Error: ${homeProvider.errorMessage}'));
        } else if (homeProvider.doctorProfile != null) {
          final doctorProfile = homeProvider.doctorProfile!;
          return  SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              // mainAxisSize: MainAxisSize.min,
              children: [
                const  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
                  child: Align(alignment: AlignmentDirectional.topStart,child:  Text('Welcome', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor, fontSize: 20.0),)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
                  child: Align(alignment: AlignmentDirectional.topStart,child: Text(doctorProfile.data!.firstName!, style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.verdigris, fontSize: 30.0),)),
                ),
                Expanded(
                  child: SfCalendar(
                    onTap: _onCalendarTap,
                    view: CalendarView.day,
                    dataSource: MeetingDataSource(_getDataSource()),
                    monthViewSettings: const MonthViewSettings(
                        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      }),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(minutes: 180));
    meetings.add(Meeting(
        'Meeting with CM \n\n(CM House)', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting(
        'Reshita Office', startTime, endTime, const Color(0xFFE339EF), false));
    return meetings;
  }

  void _onCalendarTap(CalendarTapDetails details) {
    Fluttertoast.showToast(
        msg: "Schedule",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.celeste,
        textColor: AppColors.textColor,
        fontSize: 16.0
    );
  }


}

class MeetingDataSource extends CalendarDataSource{
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class Meeting {

  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;

  DateTime from;

  DateTime to;

  Color background;

  bool isAllDay;
}
