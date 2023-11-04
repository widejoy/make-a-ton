import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 101, 4),
            ),
            child: Text(
              'Other Essentials',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.bus_alert),
            title: const Text('Bus Timing'),
            onTap: () {
              // Navigate to the settings page or perform the desired action
            },
          ),
          ListTile(
            leading: const Icon(Icons.train_outlined),
            title: const Text('Train Timing'),
            onTap: () {
              // Navigate to the settings page or perform the desired action
            },
          ),
          ListTile(
            leading: const Icon(Icons.traffic),
            title: const Text('Traffic High areas around you '),
            onTap: () {
              // Navigate to the settings page or perform the desired action
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              // Navigate to the about page or perform the desired action
            },
          ),
          const SizedBox(
            height: 428,
          ),
          ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                'Logout',
              ),
              onTap: () async {}),
        ],
      ),
    );
  }
}
