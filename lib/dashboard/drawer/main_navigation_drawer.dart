import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/constants/images.dart';

class MainNavigationDrawer extends StatelessWidget {
  const MainNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
         const UserAccountsDrawerHeader(
           decoration: BoxDecoration(
             gradient: LinearGradient(colors: [
               AppColors.mistyRose, AppColors.almond
             ],  begin: Alignment.topRight,
               end: Alignment.bottomLeft,),
           ),
            accountName: Text('Dr. Name',style: TextStyle(fontSize: 16.0, color: AppColors.textColor)),
            accountEmail: Text('example@gmail.com',style: TextStyle(fontSize: 18.0, color: AppColors.textColor)),
            currentAccountPicture: CircleAvatar(
              radius: 30.0,
              backgroundColor: Colors.white,
              child: Text(
                'D',
                style: TextStyle(fontSize: 20.0, color: Colors.blue),
              ),
            ),
          ),
          ListTile(
            leading: Image.network(HttpImages.dashboardActive),
            title: const Text('Dashboard'),
            onTap: (){},
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/clinic.svg",),
            title: const Text('Clinics'),
            onTap: (){},
          ),
          ListTile(
            leading: SvgPicture.network(HttpImages.appointmentActive, height: 20.0, width: 20.0,),
            title: const Text('Appointments'),
            onTap: (){},
          ),
          ListTile(
            leading: Image.network(HttpImages.accountActive),
            title: const Text('Accounts'),
            onTap: (){},
          ),
          ListTile(
            leading: Image.network(HttpImages.helpActive),
            title: const Text('Help'),
            onTap: (){},
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: (){},
          ),
          const SizedBox(height: 25.0,),
        ],
      ),
    );
  }
}
