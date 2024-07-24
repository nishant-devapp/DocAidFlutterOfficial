import 'package:code/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final List<int> _navigationStack = [0];
  late Future<void> _initFuture;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ClinicScreen(),
    const AppointmentScreen(),
    const AccountMainScreen(),
    const HelpScreen(),
  ];

  Future<void> _fetchData() async {
    try {
      final doctorProvider = Provider.of<HomeProvider>(context, listen: false);
      await doctorProvider.fetchDoctorDetail();
    } catch (e) {
      throw Exception('Failed to retrieve token or fetch data: $e');
    }
  }

  final List<String> _titles = [
    'Dashboard',
    'Clinics',
    'Appointments',
    'Accounts',
    'Help',
  ];

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
  void initState() {
    super.initState();
    _initFuture = _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final doctorProvider = Provider.of<HomeProvider>(context);

    return FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error retrieving data'));
        }
        return WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: AppBar(
              title: Text(_titles[_selectedIndex]),
            ),
            drawer: MainNavigationDrawer(onItemTapped: _onItemTapped),
            body: doctorProvider.loading
                ? const Center(child: CircularProgressIndicator())
                : doctorProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(doctorProvider.errorMessage))
                    : _screens[_selectedIndex],
          ),
        );
      },
    );
  }
}
