import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/Authentication/screens/Signup.dart';
import 'package:my_project/Authentication/screens/login.dart';
import 'package:my_project/screens/Introduction.dart';
import 'package:my_project/screens/create_post_screen.dart';
import 'package:my_project/screens/featured.dart';
import 'package:my_project/screens/near_me.dart';
import 'package:my_project/screens/onbording.dart';
import 'package:my_project/widgets/drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MaterialApp(
      home: Intro(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
              icon: Icon(Icons.area_chart_outlined),
              label: 'Near Me',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.featured_play_list),
              icon: Icon(Icons.featured_play_list_outlined),
              tooltip: 'Click here to find the hottest posts',
              label: 'Featured',
            ),
            NavigationDestination(
                tooltip: 'Click here to upload an issue',
                selectedIcon: Icon(Icons.create_rounded),
                icon: Icon(Icons.create_outlined),
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
