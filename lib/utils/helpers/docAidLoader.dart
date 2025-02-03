import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DocAidLoader extends StatelessWidget {
  const DocAidLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      'assets/lottie/doc-aidLoader.json',
      height: 220.0,
      width: 220.0,
      repeat: true,
    );
  }
}