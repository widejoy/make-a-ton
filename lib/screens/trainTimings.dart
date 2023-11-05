import 'package:flutter/material.dart';

class Train extends StatefulWidget {
  const Train({super.key});

  @override
  State<Train> createState() => _TrainState();
}

class _TrainState extends State<Train> {
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
              'assets/train.jpeg',
              height: 300,
              alignment: Alignment.topCenter,
            ),
            const SizedBox(height: 20),
            const Text(
              "Train Timings",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            const ListTile(
              title: Text("Train 1",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              subtitle: Text("Time -> 12:00pm"),
            ),
            const ListTile(
              title: Text("Train 2",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              subtitle: Text("Time -> 12:00pm"),
            ),
            const ListTile(
              title: Text("Train 3",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300)),
              subtitle: Text("Time -> 12:00pm"),
            ),
          ],
        ),
      ),
    );
  }
}
