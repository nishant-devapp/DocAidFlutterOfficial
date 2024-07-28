import 'package:code/appointments/providers/appointment_provider.dart';
import 'package:code/auth/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/provider/home_provider.dart';

void main() => runApp(
    MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeGetProvider()),
      ChangeNotifierProvider(create: (_) => AppointmentProvider()),
    ],
    child: const DocAid()));


class DocAid extends StatelessWidget {
  const DocAid({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Doc-Aid',
      themeMode: ThemeMode.light,
      home: LoginScreen(),
    );
  }
}
