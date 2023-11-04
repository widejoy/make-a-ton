import 'package:flutter/material.dart';
import 'package:share/share.dart';

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
      this.organisationname = ""})
      : super(key: key);

  final String username;
  final String title;
  final String location;
  final String description;
  int votecount;
  final int progress;
  String organisationname;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isupvoted = false;
  bool isdownvoted = false;
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
    return Card(
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
          Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg/1200px-Outdoors-man-portrait_%28cropped%29.jpg',
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.description,
              style: const TextStyle(fontSize: 16),
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
                Text(
                  'This is being hanngled by:${widget.organisationname}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
                Text(
                  'This is fixed by:${widget.organisationname}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
