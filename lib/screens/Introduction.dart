import 'package:flutter/material.dart';
import 'package:my_project/screens/onbording.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      home: Onbording(),
    );
  }
}
