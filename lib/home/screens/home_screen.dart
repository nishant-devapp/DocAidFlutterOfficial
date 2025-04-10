// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../accounts/screens/account_main_screen.dart';
// import '../../appointments/screens/appointment_screen.dart';
// import '../../clinics/screens/clinic_screen.dart';
// import '../../dashboard/screens/dashboard_screen.dart';
// import '../../help/screens/help_screen.dart';
// import '../../home/drawer/main_navigation_drawer.dart';
// import '../../utils/constants/colors.dart';
// import '../provider/home_provider.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;
//   final List<int> _navigationStack = [0];
//
//   final List<Widget> _screens = [
//     const DashboardScreen(),
//     const ClinicScreen(),
//     const AppointmentScreen(),
//     const AccountMainScreen(),
//     const HelpScreen(),
//   ];
//
//   final List<String> _titles = [
//     'Dashboard',
//     'Clinics',
//     'Appointments',
//     'Accounts',
//     'Help',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorProfile();
//       Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorImage();
//     });
//   }
//
//
//
//   Future<bool> _onWillPop() async {
//     if (_navigationStack.length > 1) {
//       setState(() {
//         _navigationStack.removeLast();
//         _selectedIndex = _navigationStack.last;
//       });
//       return false;
//     } else {
//       return true; // Allow the app to exit if on the dashboard screen
//     }
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       _navigationStack.add(index);
//     });
//     Navigator.pop(context); // Close the drawer
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<HomeGetProvider>(builder: (context, homeProvider, child) {
//       if (homeProvider.isLoading) {
//         return const Center(child: CircularProgressIndicator());
//       } else if (homeProvider.errorMessage != null) {
//         return Center(child: Text('Error: ${homeProvider.errorMessage}'));
//       } else if (homeProvider.doctorProfile != null) {
//         final docProfile = homeProvider.doctorProfile!;
//         return  WillPopScope(
//           onWillPop: _onWillPop,
//           child: Scaffold(
//             appBar: AppBar(
//               title: Text(_titles[_selectedIndex]),
//               // backgroundColor: AppColors.appBackgroundColor,
//             ),
//             drawer: MainNavigationDrawer(onItemTapped: _onItemTapped),
//             body: _screens[_selectedIndex],
//           ),
//         );
//       } else {
//         return const Center(child: Text('No data available'));
//       }
//     });
//   }
// }

import 'package:code/profile/screens/doctor_profile_screen.dart';
import 'package:code/utils/helpers/docAidLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/screens/account_main_screen.dart';
import '../../appointments/screens/appointment_screen.dart';
import '../../auth/screens/LoginScreen.dart';
import '../../clinics/screens/clinic_screen.dart';
import '../../dashboard/screens/dashboard_screen.dart';
import '../../help/screens/help_screen.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/TokenManager.dart';
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
    const DoctorProfileScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Clinics',
    'Appointments',
    'Accounts',
    'My Profile',
  ];

  /// List of SVG icon paths (unselected and selected)
  final List<Map<String, String>> _icons = [
    {
      'unselected': 'assets/svg/bottom_nav_unselected_dashboard.svg',
      'selected': 'assets/svg/bottom_nav_selected_dashboard.svg'
    },
    {
      'unselected': 'assets/svg/bottom_nav_unselected_clinic.svg',
      'selected': 'assets/svg/bottom_nav_selected_clinic.svg'
    },
    {
      'unselected': 'assets/svg/bottom_nav_unselected_appointment.svg',
      'selected': 'assets/svg/bottom_nav_selected_appointment.svg'
    },
    {
      'unselected': 'assets/svg/bottom_nav_unselected_account.svg',
      'selected': 'assets/svg/bottom_nav_selected_account.svg'
    },
    {
      'unselected': 'assets/svg/bottom_nav_unselected_profile.svg',
      'selected': 'assets/svg/clinic.svg'
    },
  ];

  /// List of colors for selected text and icon
  final List<Color> _selectedColors = [
    Colors.black, // Dashboard
    AppColors.princetonOrange, // Clinics
    AppColors.verdigris, // Appointments
    AppColors.vermilion, // Accounts
    AppColors.helpColor, // Help
  ];

  void _onMenuSelected(String value) {
    if (value == 'help') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HelpScreen()),
      );
    } else if (value == 'logout') {
      _logout();
    }
  }

  void _logout() async {
    await TokenManager().deleteToken();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorProfile();
      Provider.of<HomeGetProvider>(context, listen: false).fetchDoctorImage();
    });
  }

  // Future<bool> _onWillPop() async {
  //   if (_navigationStack.length > 1) {
  //     setState(() {
  //       _navigationStack.removeLast();
  //       _selectedIndex = _navigationStack.last;
  //     });
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0; // Navigate to Dashboard
      });
      return false; // Prevent default back navigation
    }
    return true; // Allow default back navigation (exit app)
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navigationStack.add(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeGetProvider>(builder: (context, homeProvider, child) {
      // if (homeProvider.isLoading) {
      //   return const Center(child: DocAidLoader());
      // } else if (homeProvider.errorMessage != null) {
      //   return Center(child: Text('Error: ${homeProvider.errorMessage}'));
      // } else if (homeProvider.doctorProfile != null) {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(_titles[_selectedIndex]),
            actions: [
              PopupMenuButton<String>(
                onSelected: _onMenuSelected,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'help',
                    child: ListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/help.svg',
                        height: 23.0,
                        width: 23.0,
                      ),
                      title: const Text('Help'),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'logout',
                    child: ListTile(
                      leading: SvgPicture.asset(
                        'assets/svg/logout.svg',
                        height: 18.0,
                        width: 18.0,
                      ),
                      title: const Text('Logout'),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // body: _screens[_selectedIndex],
          body: homeProvider.isLoading
              ? const Center(
                  child: DocAidLoader(),
                )
              : _screens[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              _onItemTapped(index);
            },
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: List.generate(_titles.length, (index) {
              bool isSelected = _selectedIndex == index;

              // If last item, show CircleAvatar instead of an SVG icon
              if (index == _titles.length - 1) {
                return BottomNavigationBarItem(
                  icon: CircleAvatar(
                    radius: 14,
                    backgroundColor: isSelected
                        ? _selectedColors[index]
                        : Colors.grey.shade300,
                    backgroundImage: homeProvider.profileImage != null
                        ? MemoryImage(homeProvider
                            .profileImage!) // Profile Image from API
                        : null, // No background image if not available
                    child: homeProvider.profileImage == null
                        // ? const Icon(Icons.person, color: Colors.white, size: 18) // Default avatar
                        ? SvgPicture.asset(
                            'assets/svg/bottom_nav_unselected_profile.svg',
                            height: 22,
                            width: 22,
                          ) // Default avatar
                        : null, // Hide child if profile image is present
                  ),
                  label: 'Profile',
                );
              }

              // Default case: Normal SVG icon
              return BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  isSelected
                      ? _icons[index]['selected']!
                      : _icons[index]['unselected']!,
                  height: 22,
                  width: 22,
                  colorFilter: ColorFilter.mode(
                    isSelected ? _selectedColors[index] : Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),
                label: _titles[index],
              );
            }),
            selectedItemColor: _selectedColors[_selectedIndex],
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      );
      // } else {
      //   return const Center(child: Text('No data available'));
      // }
    });
  }
}
