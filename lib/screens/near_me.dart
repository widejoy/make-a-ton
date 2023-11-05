import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_project/widgets/postwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NearMe extends StatefulWidget {
  const NearMe({super.key});

  @override
  _NearMeState createState() => _NearMeState();
}

class _NearMeState extends State<NearMe> {
  bool? type;

  void gettype() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userType = prefs.getBool('isUser');

    setState(() {
      type = userType;
    });
  }

  @override
  void initState() {
    gettype();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final posts = snapshot.data!.docs
              .map((doc) => PostWidget(
                    organisationname: doc['organisationanme'],
                    isvolunteer: doc['isvolunteer'],
                    isUser: type!,
                    imageUrls: doc.id,
                    time: doc['timestamp'],
                    username: doc['uid'],
                    title: doc['title'],
                    location: doc['location'],
                    description: doc['description'],
                    votecount: doc['votes'],
                    progress: doc['progress'],
                  ))
              .toList();

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostWidget(
                organisationname: posts[index].organisationname,
                isvolunteer: posts[index].isvolunteer,
                isUser: type!,
                imageUrls: posts[index].imageUrls,
                time: posts[index].time,
                username: posts[index].username,
                title: posts[index].title,
                location: posts[index].location,
                description: posts[index].description,
                votecount: posts[index].votecount,
                progress: posts[index].progress,
              );
            },
          );
        },
      ),
    );
  }
}
