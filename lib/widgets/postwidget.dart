import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:my_project/screens/profilepage.dart';
import 'package:share/share.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class PostWidget extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  PostWidget(
      {Key? key,
      required this.username,
      required this.title,
      required this.location,
      required this.description,
      required this.votecount,
      required this.progress,
      required this.time,
      this.organisationname = "",
      required this.imageUrls,
      required this.isUser,
      required this.isvolunteer})
      : super(key: key);

  final String username;
  final bool isvolunteer;
  final String title;
  final bool isUser;
  final String imageUrls;
  final Timestamp time;
  final String location;
  final String description;
  int votecount;
  final int progress;
  String organisationname;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  FirebaseStorage storage = FirebaseStorage.instance;

  bool isupvoted = false;
  bool isloading = false;
  TextEditingController how = TextEditingController();
  TextEditingController deadline = TextEditingController();
  int _currentImageIndex = 0;
  bool isdownvoted = false;
  Future<List<String>> getFileNamesInFirebaseStorage(
      String directoryPath) async {
    ListResult result = await storage.ref().child(directoryPath).listAll();

    List<String> fileNames = result.items.map((item) => item.name).toList();

    return fileNames;
  }

  Future<void> loadImages() async {
    isloading = true;
    List<String> fileNames =
        await getFileNamesInFirebaseStorage('posts/${widget.imageUrls}/');
    for (var i in fileNames) {
      final Reference imageRef =
          FirebaseStorage.instance.ref().child('posts/${widget.imageUrls}/$i');
      final imageBytesData = await imageRef.getData();
      setState(() {
        imageBytes.add(Uint8List.fromList(imageBytesData!));
      });
    }
    isloading = false;
  }

  List<Uint8List> imageBytes = [];

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  Icon upicon = const Icon(
    Icons.arrow_circle_up_outlined,
  );
  Icon downicon = const Icon(Icons.arrow_circle_down_outlined);

  void upvote() {
    if (isupvoted) {
      setState(() {
        isupvoted = false;
        widget.votecount--;
        upicon = const Icon(Icons.arrow_circle_up_outlined);
      });
    } else if (isdownvoted) {
      setState(() {
        isdownvoted = false;
        isupvoted = true;
        widget.votecount = widget.votecount + 2;
        downicon = const Icon(Icons.arrow_circle_down_outlined);
        upicon = const Icon(
          Icons.arrow_circle_up,
          color: Colors.red,
        );
      });
    } else {
      setState(() {
        isupvoted = true;
        widget.votecount++;
        upicon = const Icon(
          Icons.arrow_circle_up,
          color: Colors.red,
        );
      });
    }
  }

  void downvote() {
    if (isdownvoted) {
      setState(() {
        isdownvoted = false;
        widget.votecount++;
        downicon = const Icon(Icons.arrow_circle_down_outlined);
      });
    } else if (isupvoted) {
      setState(() {
        isdownvoted = true;
        isupvoted = false;
        widget.votecount = widget.votecount - 2;
        upicon = const Icon(
          Icons.arrow_circle_up_outlined,
        );
        downicon = const Icon(
          Icons.arrow_circle_down,
          color: Colors.blue,
        );
      });
    } else {
      setState(() {
        isdownvoted = true;
        widget.votecount--;
        downicon = const Icon(
          Icons.arrow_circle_down,
          color: Colors.blue,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = widget.time.toDate();

    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return SingleChildScrollView(
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg/1200px-Outdoors-man-portrait_%28cropped%29.jpg'),
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(widget.location),
            ),
            isloading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CarouselSlider(
                    items: imageBytes.map((imageData) {
                      return Image.memory(
                        imageData,
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                  ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageBytes.map((imageData) {
                int index = imageBytes.indexOf(imageData);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentImageIndex == index ? Colors.blue : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            !widget.isUser & (widget.progress == 0) & !widget.isvolunteer
                ? Center(
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'sucesfully registered you will get updated if you are selected'),
                          ),
                        );
                      },
                      child: const Text('Contribute'),
                    ),
                  )
                : widget.isvolunteer
                    ? Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'sucesfully registered you will get updated if you are selected'),
                              ),
                            );
                          },
                          child: const Text('volunteer'),
                        ),
                      )
                    : SizedBox(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                formattedDateTime,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            if (widget.progress == 0)
              const LinearProgressIndicator(
                value: 0,
                minHeight: 8,
                backgroundColor: Colors.red,
              )
            else if (widget.progress == 1)
              Column(
                children: [
                  const LinearProgressIndicator(
                    value: 0.5,
                    minHeight: 8,
                    color: Colors.orange,
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            organisationanme: widget.organisationname),
                      ));
                    },
                    child: Text(
                      'This is being hanngled by:${widget.organisationname}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            else if (widget.progress == 2)
              Column(
                children: [
                  const LinearProgressIndicator(
                    value: 1,
                    minHeight: 8,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            organisationanme: widget.organisationname),
                      ));
                    },
                    child: Text(
                      'This is fixed by:${widget.organisationname}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: upicon,
                      onPressed: upvote,
                    ),
                    Text('${widget.votecount}'),
                    IconButton(
                      icon: downicon,
                      onPressed: downvote,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 500,
                          ),
                        );
                      },
                    ),
                    const Text('Comment'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {
                        Share.share("https://pub.dartlang.org/packages/share",
                            subject: "This is a Share Button");
                      },
                    ),
                    const Text('Share'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
