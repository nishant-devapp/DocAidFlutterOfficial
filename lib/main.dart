import 'package:code/utils/themes/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(const DocAid());

class DocAid extends StatelessWidget {
  const DocAid({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
