import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_project/widgets/postwidget.dart';

class Featured extends StatelessWidget {
  const Featured({super.key});

  @override
  Widget build(BuildContext context) {
    return PostWidget(
        isvolunteer: false,
        username: 'roger',
        title: 'title',
        location: 'kochi,kerela',
        description: 'X problem here',
        votecount: 4,
        progress: 2,
        time: Timestamp(12, 34),
        imageUrls: 'jUgiRGXDzHEldspyhJzt',
        organisationname: "rgbt",
        isUser: true);
  }
}
