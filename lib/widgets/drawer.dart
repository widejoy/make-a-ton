// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/Authentication/screens/login.dart';

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
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.train_outlined),
            title: const Text('Train Timing'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.traffic),
            title: const Text('Traffic High areas around you '),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {},
          ),
          const SizedBox(
            height: 428,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logout failed. Please try again.'),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
