import 'package:flutter/material.dart';
import 'package:my_project/screens/choosing.dart';
import 'package:my_project/screens/contentModule.dart';

class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller = PageController();

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Column(
                  children: [
                    SizedBox(height: 100),
                    Image.asset(
                      contents[i].image,
                      height: 250,
                    ),
                    SizedBox(height: 40),
                    Text(
                      contents[i].title,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(height: 50),
                    Text(
                      contents[i].description,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: ElevatedButton(
              onPressed: () {
                if (currentIndex == contents.length - 1)
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => MyForm()));
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 50),
                backgroundColor: const Color.fromARGB(255, 86, 199, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                  currentIndex == contents.length - 1 ? "Continue" : "Next"),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
        height: 10,
        width: currentIndex == index ? 20 : 10,
        margin: EdgeInsets.only(right: 5, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ));
  }
}
