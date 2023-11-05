import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Authentication/screens/Signup.dart';
import 'package:my_project/Authentication/widgets/field.dart';
import 'package:my_project/main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage = '';

  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      isLoading = true; // Set loading state to true while logging in
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Handle successful login
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
            padding: const EdgeInsets.fromLTRB(20, 200, 20, 300),
            child: Column(
              children: [
                const Text(
                  "Log in",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(600, 50),
                    backgroundColor: const Color.fromARGB(255, 86, 199, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/google-logo.png',
                        height: 40,
                        width: 90,
                      ),
                      const Text("Continue with Google"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 1,
                  color: Color.fromARGB(255, 53, 53, 53),
                ),
                customField(
                    cont: emailController, text: "Email", isPass: false),
                const SizedBox(height: 20),
                customField(
                    cont: passwordController, text: "Password", isPass: true),
                const SizedBox(height: 20),
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
                          signInWithEmailAndPassword().then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Successfully logged in!'),
                              ),
                            );
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ));
                          });
                        },
                  child: isLoading
                      ? CircularProgressIndicator() // Display loading spinner
                      : const Text('Log In'),
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
                            return const SignUp();
                          },
                        ));
                      },
                      child: const Text('Sign Up'),
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
