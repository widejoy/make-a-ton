import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/screens/featured.dart';
import 'package:my_project/screens/near_me.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
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
          ],
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 220, 101, 4),
        ),
        body: <Widget>[const NearMe(), const Featured()][currentPageIndex],
      ),
    );
  }
}
