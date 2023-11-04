import 'package:my_project/auth.dart';
import 'package:my_project/authentication/screens/login.dart';
import 'package:my_project/authentication/screens/Signup.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const SignUp();
          } else {
            return const Login();
          }
        });
  }
}
