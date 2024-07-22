import 'package:code/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const DocAid());

class DocAid extends StatelessWidget {
  const DocAid({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doc-Aid',
      themeMode: ThemeMode.light,
      home: HomeScreen(),
    );
  }
}
