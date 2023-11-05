import 'package:flutter/material.dart';

class Traffic extends StatefulWidget {
  const Traffic({super.key});

  @override
  State<Traffic> createState() => _TrafficState();
}

class _TrafficState extends State<Traffic> {
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(
          children: [
            Image.asset(
              'assets/traffic.jpeg',
              height: 350,
            ),
            const SizedBox(height: 20),
            const Text(
              "Traffic near you",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            const ListTile(
              title: Text("Petta",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ),
            const ListTile(
              title: Text("Aluva",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ),
            const ListTile(
              title: Text("Vytilla",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
            ),
          ],
        ),
      ),
    );
  }
}
