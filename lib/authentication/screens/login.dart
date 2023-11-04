import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_project/authentication/screens/Signup.dart';
import 'package:my_project/authentication/widgets/field.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 218, 244, 244),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              20, 300, 20, 0), // Adjust the padding as needed
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Row(children: [
                  Image.asset(
                    'assets/google-logo.png',
                    height: 40,
                    width: 90,
                  ),
                  Text("Continue with Google"),
                ]),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(600, 50),
                  backgroundColor: Color.fromARGB(255, 86, 199, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                color: Color.fromARGB(255, 53, 53, 53),
              ),
              const SizedBox(height: 20),
              customField(emailController, "Email"),
              const SizedBox(height: 20),
              customField(passwordController, "Password"),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(600, 50),
                  backgroundColor: Color.fromARGB(255, 86, 199, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  } catch (e) {
                    // Sign-in failed, handle the error (e.g., show an error message)
                    print('Sign-in error: $e');
                  }
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
    );
  }
}
