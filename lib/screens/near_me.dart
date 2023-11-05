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
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    final userType = _prefs.getBool('isUser');

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
      body: type == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final posts = snapshot.data!.docs
                    .map((doc) => PostWidget(
                          isUser: type!,
                          organisationname: doc["organisationname"],
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
                      isUser: type!,
                      organisationname: posts[index].organisationname,
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
