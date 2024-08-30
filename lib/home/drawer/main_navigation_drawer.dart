import 'package:code/auth/screens/LoginScreen.dart';
import 'package:code/profile/screens/doctor_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/helpers/TokenManager.dart';
import '../../utils/constants/colors.dart';
import '../provider/home_provider.dart';
import '../widgets/doctor_profile_base.dart';

class MainNavigationDrawer extends StatelessWidget {
  final Function(int) onItemTapped;

  const MainNavigationDrawer({required this.onItemTapped, super.key});

  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(
      builder: (HomeGetProvider homeProvider) {
        final doctorProfile = homeProvider.doctorProfile!;
        // final doctorImage = homeProvider.profileImage!;
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
                accountName: Text(doctorProfile.data!.firstName! ,
                    style: const TextStyle(fontSize: 16.0, color: AppColors.textColor, fontWeight: FontWeight.w500)),
                accountEmail: Text(doctorProfile.data!.email!,
                    style: const TextStyle(fontSize: 16.0, color: AppColors.textColor, fontWeight: FontWeight.w400)),
                currentAccountPicture: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DoctorProfileScreen()));},
                  child:  CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: homeProvider.profileImage != null
                        ? MemoryImage(homeProvider.profileImage!)
                        : null, // Show image if available
                    child: homeProvider.profileImage == null
                        ? const Text(
                      'X',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    )
                        : null, // Show 'X' if no image
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
                onTap: () async{
                  // Delete token and clear shared preferences before navigating
                  await TokenManager().deleteToken();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear();

                  // Navigate to the login screen and remove all previous routes
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        );
      },
    );
  }
}
