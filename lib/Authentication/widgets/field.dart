import 'package:flutter/material.dart';

TextField customField({
  TextEditingController? cont,
  String? text,
  bool isPass = false,
}) {
  return TextField(
    keyboardType: isPass ? TextInputType.visiblePassword : TextInputType.text,
    autocorrect: true,
    controller: cont,
    obscureText: isPass,
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 253, 241, 255),
      labelText: text,
      labelStyle: const TextStyle(
        color: Color.fromARGB(255, 121, 120, 121),
        fontSize: 16.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 93, 92, 93),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
    ),
  );
}
