import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Authentication/screens/login.dart';
import 'package:my_project/Authentication/widgets/field.dart';
import 'package:my_project/screens/onboarding.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? errorMessage = '';
  bool isLoading = false; // Add isLoading flag

  Future<void> createUserWithEmailAndPassword() async {
    setState(() {
      isLoading = true; // Set loading state to true while creating the account
    });

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final User? user = userCredential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': usernameController.text,
          'email': emailController.text,
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
        isLoading =
            false; // Set loading state back to false in case of an error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 218, 244, 244),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 170, 20, 300),
            child: Column(
              children: [
                const Text(
                  "Create account",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                customField(
                    cont: usernameController, text: "Username", isPass: false),
                const SizedBox(height: 20),
                customField(
                    cont: emailController, text: "Email", isPass: false),
                const SizedBox(height: 20),
                customField(
                    cont: passwordController, text: "Password", isPass: true),
                const SizedBox(height: 70),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(600, 50),
                    backgroundColor: const Color.fromARGB(255, 86, 199, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: isLoading
                      ? null
                      : () {
                          createUserWithEmailAndPassword().then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Account created successfully!'),
                              ),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => Onbording(),
                              ),
                            );
                          });
                        },
                  child: isLoading
                      ? CircularProgressIndicator() // Display loading spinner
                      : const Text("Sign up"),
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    const Text(
                      "Already have an account?",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const Login();
                          },
                        ));
                      },
                      child: const Text('Login'),
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
