import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Authentication/widgets/field.dart';
import 'package:my_project/auth.dart';
import 'package:my_project/authentication/screens/Signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage = '';
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 218, 244, 244),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                20, 300, 20, 0), // Adjust the padding as needed
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(600, 50),
                    backgroundColor: Color.fromARGB(255, 86, 199, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(children: [
                    Image.asset(
                      'assets/google-logo.png',
                      height: 40,
                      width: 90,
                    ),
                    const Text("Continue with Google"),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 53, 53, 53),
                ),
                const SizedBox(height: 20),
                customField(
                    cont: emailController, text: "Email", isPass: false),
                const SizedBox(height: 20),
                customField(
                    cont: passwordController, text: "Password", isPass: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(600, 50),
                    backgroundColor: Color.fromARGB(255, 86, 199, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    signInWithEmailAndPassword().then((value) {
                      FirebaseFirestore.instance.doc("Users").update(
                        {},
                      );
                    });
                  },
                  child: Text('Log In'),
                ),
                Row(
                  children: [
                    const Text(
                      "Don't have an account?",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return SignUp();
                          },
                        ));
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
