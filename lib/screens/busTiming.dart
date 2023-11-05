import 'package:flutter/material.dart';

class Bus extends StatefulWidget {
  const Bus({super.key});

  @override
  State<Bus> createState() => _BusState();
}

class _BusState extends State<Bus> {
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
          actions: [
            Center(
                child: Image.asset(
              'assets/logo.png',
              scale: 5,
            )),
          ],
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
              'assets/bus-await.jpeg',
              height: 350,
            ),
            const SizedBox(height: 20),
            const Text(
              "Bus Timings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            const ListTile(
              title: Text("Kochi -> Trivandrum",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              subtitle: Text("Time -> 2:00am"),
            ),
            const ListTile(
              title: Text("Alapuzha -> Kottayam",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              subtitle: Text("Time -> 7:30am"),
            ),
            const ListTile(
              title: Text("Kottayam -> Aluva",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              subtitle: Text("Time -> 12:00pm"),
            ),
          ],
        ),
      ),
    );
  }
}
