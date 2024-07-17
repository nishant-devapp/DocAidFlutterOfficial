import 'package:flutter/material.dart';

import '../../accounts/screens/account_main_screen.dart';
import '../../appointments/screens/appointment_screen.dart';
import '../../clinics/screens/clinic_screen.dart';
import '../../home/drawer/main_navigation_drawer.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../help/screens/help_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

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

  void _onWillPop(bool shouldPop) {
    if (shouldPop) {
      if (_selectedIndex == 0) {
        Navigator.of(context).maybePop(); // Exit the app
      } else {
        setState(() {
          _selectedIndex = 0; // Go to dashboard
        });
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text(_titles[_selectedIndex])),
        drawer: MainNavigationDrawer(onItemTapped: _onItemTapped),
        body: _screens[_selectedIndex],
      ), );
  }
}
