import 'package:code/auth/screens/LoginScreen.dart';
import 'package:code/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
    create: (context) => HomeProvider(), child: const DocAid()));

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
