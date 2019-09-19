import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';


class ChatMessage extends StatelessWidget {
  ChatMessage(
      {this.text,
      this.email,
      this.pic,
      this.name,
      this.e,
      this.type,
      this.url});

  final String text, email, pic, name, e, type, url;

  @override
  Widget build(BuildContext context) {
    final chewieController = ChewieController(
      videoPlayerController:VideoPlayerController.network(url),

      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );

    var x = Colors.green;
    if (email == e) {
      x = Colors.blue;
    }

    if (type == "image") {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CircleAvatar(
                      child: Image.network(pic),
                    ),
                  ),
                ),
                Container(
                  child: Text(name, style: TextStyle(color: x)),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(55.0, 10.0, 0.0, 0.0),
                height: 300.0,
                child: PhotoView(
                  imageProvider: NetworkImage(url),
                ))
          ],
        ),
      );
    } else if (type == "video") {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CircleAvatar(
                      child: Image.network(pic),
                    ),
                  ),
                ),
                Container(
                  child: Text(name, style: TextStyle(color: x)),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(55.0, 10.0, 0.0, 0.0),
                child: Chewie(
                  controller: chewieController,
                )
            )
          ],
        ),
      );
    } else if (type == "text") {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: CircleAvatar(
                  child: Image.network(pic),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: TextStyle(color: x)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (type == 'contact') {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: CircleAvatar(
                  child: Image.network(pic),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: TextStyle(color: x)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: InkWell(
                      child: Text(
                        "Call - $url",
                        style: TextStyle(color: Colors.brown),
                      ),
                      onTap: () => {}),
                ),
              ],
            ),
          ],
        ),
      );
    } else if (type == 'location') {
      var location = url.split('@');
      String latitude = location[0], longitude = location[1];
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CircleAvatar(
                      child: Image.network(pic),
                    ),
                  ),
                ),
                Container(
                  child: Text(name, style: TextStyle(color: x)),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(55.0, 10.0, 0.0, 0.0),
                height: 300.0,
                child: PhotoView(
                  imageProvider: NetworkImage(
                      "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=18&size=640x400&key=YOUR_API_KEY"),
                ))
          ],
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: CircleAvatar(
                  child: Image.network(pic),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: TextStyle(color: x)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Text("Please update your app to see this content!"),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
