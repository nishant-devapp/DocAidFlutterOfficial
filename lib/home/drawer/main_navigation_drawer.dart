import 'package:code/profile/screens/doctor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/helpers/TokenManager.dart';
import '../../utils/constants/colors.dart';

class MainNavigationDrawer extends StatelessWidget {
  final Function(int) onItemTapped;

  const MainNavigationDrawer({required this.onItemTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.mistyRose, AppColors.almond],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            accountName: Text('Dr. Name',
                style: TextStyle(fontSize: 16.0, color: AppColors.textColor)),
            accountEmail: Text('example@gmail.com',
                style: TextStyle(fontSize: 18.0, color: AppColors.textColor)),
            currentAccountPicture: InkWell(
              onTap: (){
                Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DoctorProfileScreen()));},
              child: const CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.white,
                child: Text(
                  'D',
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg/dashboard.svg',
              height: 32,
              width: 32,
              colorFilter: const ColorFilter.mode(
                  AppColors.dashboardColor, BlendMode.srcIn),
            ),
            title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor)),
            onTap: () => onItemTapped(0),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg/clinic.svg',
              height: 32,
              width: 32,
              colorFilter: const ColorFilter.mode(
                  AppColors.clinicColor, BlendMode.srcIn),
            ),
            title: const Text('Clinics', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor)),
            onTap: () => onItemTapped(1),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg/appointment.svg',
              height: 32,
              width: 32,
              colorFilter: const ColorFilter.mode(
                  AppColors.appointmentColor, BlendMode.srcIn),
            ),
            title: const Text('Appointments', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor)),
            onTap: () => onItemTapped(2),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg/accounts.svg',
              height: 32,
              width: 32,
              colorFilter: const ColorFilter.mode(
                  AppColors.accountColor, BlendMode.srcIn),
            ),
            title: const Text('Accounts', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor)),
            onTap: () => onItemTapped(3),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/svg/help.svg',
              height: 32,
              width: 32,
              colorFilter:
              const ColorFilter.mode(AppColors.helpColor, BlendMode.srcIn),
            ),
            title: const Text('Help', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor)),
            onTap: () => onItemTapped(4),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 32,
              color: AppColors.vermilion,
            ),
            title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor)),
            onTap: () {
              Navigator.pop(context);
              TokenManager().deleteToken();
            },
          ),
          const SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
