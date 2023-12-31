import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/main.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  String selectedValue = 'Normal User';

  void saveToFireStore(String selectedValue) {
    User? currentuser = FirebaseAuth.instance.currentUser;
    String uid = currentuser!.uid;
    Map<String, dynamic> data = {"type": selectedValue};
    if (selectedValue == "Organisation") {
      data = {"type": selectedValue, "jobs": <String>[]};
    }
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(data, SetOptions(merge: true))
        .then((value) {
      print('Selected value saved to Firestore');
    }).catchError((error) {
      print('Error saving selected value: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 240),
                const Text(
                  "Select your prefered account type",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 253, 241, 255),
                    labelText: "Select Subject",
                    labelStyle: const TextStyle(
                      fontSize: 16.0,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 86, 199, 255), width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: const Color.fromARGB(255, 86, 199, 255)
                              .withOpacity(0.7),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  value: selectedValue,
                  items: list,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text('Selected Value: $selectedValue'),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const MyApp()));
                    saveToFireStore(selectedValue);
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(600, 50),
                    backgroundColor: const Color.fromARGB(255, 86, 199, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> list = [
  const DropdownMenuItem(
    value: "Normal User",
    child: Text("Normal User"),
  ),
  const DropdownMenuItem(
    value: "Organisation",
    child: Text("Organisation"),
  ),
];
