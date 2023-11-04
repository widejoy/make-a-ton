import 'package:flutter/material.dart';
import 'package:my_project/screens/onboarding.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      home: Onbording(),
    );
  }
}
