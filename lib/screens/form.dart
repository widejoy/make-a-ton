import 'package:flutter/material.dart';
import 'package:my_project/widgets/custom_field.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController how = TextEditingController();
    TextEditingController deadline = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          customField(how, "how do you plan on solving this issue"),
          customField(deadline, "when do you plan on solving the issue")
        ],
      ),
    );
  }
}
