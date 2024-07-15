import 'package:code/auth/screens/LoginScreen.dart';
import 'package:code/utils/themes/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const DocAid());

class DocAid extends StatelessWidget {
  const DocAid({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}
