import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/screens/create_post_screen.dart';
import 'package:my_project/screens/featured.dart';
import 'package:my_project/screens/near_me.dart';
import 'package:my_project/widget_tree.dart';
import 'package:my_project/widgets/drawer.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance
      .activate(androidProvider: AndroidProvider.playIntegrity);

  runApp(
    const MaterialApp(
      home: Scaffold(
        body: WidgetTree(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    settype();
  }

  void settype() async {
    User? currentuser = FirebaseAuth.instance.currentUser;
    String uid = currentuser!.uid;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot document =
        await firestore.collection('users').doc(uid).get();
    if (document["type"] == "Normal User") {
      await prefs.setBool('isUser', true);
    } else {
      await prefs.setBool('isUser', false);
    }
  }

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(color: Colors.white),
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 220, 101, 4),
        ),
        drawer: const MyDrawer(),
        bottomNavigationBar: NavigationBar(
          backgroundColor: const Color.fromARGB(255, 220, 101, 4),
          indicatorColor: Colors.amber[800],
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.area_chart),
              tooltip: 'Click here to find posts near you',
              icon: Icon(
                Icons.area_chart_outlined,
                color: Colors.white,
              ),
              label: 'Near Me',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.featured_play_list),
              icon: Icon(
                Icons.featured_play_list_outlined,
                color: Colors.white,
              ),
              tooltip: 'Click here to find the hottest posts',
              label: 'Featured',
            ),
            NavigationDestination(
                tooltip: 'Click here to upload an issue',
                selectedIcon: Icon(Icons.create_rounded),
                icon: Icon(
                  Icons.create_outlined,
                  color: Colors.white,
                ),
                label: 'Report a problem')
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        body: <Widget>[
          const NearMe(),
          const Featured(),
          const CreatePostScreen()
        ][currentPageIndex],
      ),
    );
  }
}
