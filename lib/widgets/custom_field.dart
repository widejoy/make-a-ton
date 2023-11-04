import 'package:flutter/material.dart';

TextField customField(
  TextEditingController cont,
  String text, {
  bool isnum = false,
}) {
  return TextField(
    keyboardType: isnum ? const TextInputType.numberWithOptions() : null,
    autocorrect: true,
    controller: cont,
    style: const TextStyle(
      color: Colors.orangeAccent,
      fontSize: 16.0,
    ),
    decoration: InputDecoration(
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 253, 241),
      labelText: text,
      labelStyle: const TextStyle(
        color: Colors.orange,
        fontSize: 16.0,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.orange, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: Colors.orange.withOpacity(0.7), width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
  );
}
