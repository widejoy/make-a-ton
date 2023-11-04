import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.organisationanme});
  final String organisationanme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(organisationanme),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage:
                    NetworkImage('https://example.com/organization_logo.jpg'),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              organisationanme,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Credit Points: 100',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              height: 12,
            ),
            const SizedBox(height: 10),
            const Text(
              'Achievements:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              '1. Award for Community Service',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              '2. Fundraising Success',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Suspendisse ac ligula ut tellus varius cursus. Phasellus euismod '
              'nisl in lectus laoreet rhoncus.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
