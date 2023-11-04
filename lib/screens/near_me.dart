import 'package:flutter/material.dart';
import 'package:my_project/widgets/postwidget.dart';

class NearMe extends StatelessWidget {
  const NearMe({super.key});

  @override
  Widget build(BuildContext context) {
    return PostWidget(
        username: 'user',
        organisationname: "roger grtp",
        title: 'Pothole in my area',
        location: 'kolkata,india',
        description: "big hole",
        votecount: 5,
        progress: 2);
  }
}
