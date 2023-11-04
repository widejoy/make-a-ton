import 'package:flutter/material.dart';
import 'package:my_project/authentication/screens/login.dart';
import 'package:my_project/authentication/widgets/field.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 218, 244, 244),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
          child: Column(
            children: [
              // const Divider(
              //   thickness: 1,
              //   color: Color.fromARGB(255, 53, 53, 53),
              // ),
              const Text(
                "Create account",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              customField(usernameController, "Username"),
              const SizedBox(height: 20),
              customField(emailController, "Email"),
              const SizedBox(height: 20),
              customField(passwordController, "Password"),
              const SizedBox(height: 70),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(600, 50),
                  backgroundColor: Color.fromARGB(255, 86, 199, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {},
                child: Text("Sign up"),
              ),
              SizedBox(height: 20),
              const Divider(
                thickness: 1,
                color: Colors.black,
              ),
              Row(
                children: [
                  SizedBox(height: 20),
                  const Text(
                    "Already have an account?",
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ));
                    },
                    child: Text('Login'),
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
