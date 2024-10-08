import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../accounts/screens/account_main_screen.dart';
import '../../appointments/screens/appointment_screen.dart';
import '../../clinics/screens/clinic_screen.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../help/screens/help_screen.dart';
import '../../home/drawer/main_navigation_drawer.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<int> _navigationStack = [0];

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ClinicScreen(),
    const AppointmentScreen(),
    const AccountMainScreen(),
    const HelpScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Clinics',
    'Appointments',
    'Accounts',
    'Help',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorProfile();
      Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorImage();
    });
  }



  Future<bool> _onWillPop() async {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
        _selectedIndex = _navigationStack.last;
      });
      return false;
    } else {
      return true; // Allow the app to exit if on the dashboard screen
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navigationStack.add(index);
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeGetProvider>(builder: (context, homeProvider, child) {
      if (homeProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (homeProvider.errorMessage != null) {
        return Center(child: Text('Error: ${homeProvider.errorMessage}'));
      } else if (homeProvider.doctorProfile != null) {
        final docProfile = homeProvider.doctorProfile!;
        return  WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBar(
              title: Text(_titles[_selectedIndex]),
            ),
            drawer: MainNavigationDrawer(onItemTapped: _onItemTapped),
            body: _screens[_selectedIndex],
          ),
        );
      } else {
        return const Center(child: Text('No data available'));
      }
    });
  }
}
