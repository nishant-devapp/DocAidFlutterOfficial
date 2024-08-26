import 'package:code/accounts/provider/account_provider.dart';
import 'package:code/appointments/providers/appointment_provider.dart';
import 'package:code/appointments/providers/prescription_provider.dart';
import 'package:code/auth/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/provider/home_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => HomeGetProvider()),
            ChangeNotifierProvider(create: (_) => AppointmentProvider()),
            ChangeNotifierProvider(create: (_) => PrescriptionProvider()),
            ChangeNotifierProvider(create: (_) => AccountProvider()),
          ],
          child: const DocAid()));
}


class DocAid extends StatelessWidget {
  const DocAid({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doc-Aid',
      themeMode: ThemeMode.light,
      home: LoginScreen(),
    );
  }
}
