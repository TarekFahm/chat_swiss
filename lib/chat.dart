// import 'dart:io';
// import 'dart:math';
import 'package:chat_swiss/single_message.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Schat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schat',
      home: ChatScreen(),
    );
  }
}
final reference = FirebaseDatabase.instance.reference().child('messages');

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ContactPicker _contactPicker = ContactPicker();
  //Contact _contact;


  @override
  void initState() {
    getCredential();
    super.initState();
  }

  final TextEditingController _msg = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
            child: FirebaseAnimatedList(
              query: reference,
              sort: (a, b) => b.key.compareTo(a.key),
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder:
                  (_, DataSnapshot snapshot, Animation<double> animation, int) {
                return ChatMessage(
                  text: snapshot.value['text'],
                  email: snapshot.value['senderEmail'],
                  pic: snapshot.value['pic'],
                  name: snapshot.value['name'],
                  e: _email,
                  type: snapshot.value['type'],
                  url: snapshot.value['url'],
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Check-in ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {},
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                  color: Colors.green,
                ),
                SizedBox(width: 7,),
                RaisedButton(child:
                Text('Check-out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                  onPressed: () {},
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
                  color: Colors.red,
                )
              ],
            ),

          Divider(height:1.0),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.add, color: Colors.blue), onPressed: () {}),
                Flexible(
                  child:TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Aa'),
                    controller: _msg,
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.send,color: Colors.blue,),
                    onPressed: () {
                      sendMsg(_msg.text, "text", "text");
                      _msg.clear();
//
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _email, _pic , _name ;
  sendMsg(String txt, String type, String url) {
    setState(() {
      reference.push().set({
        'text': txt,
        'type': type,
        'url': url,
        'senderEmail': _email,
        'name': _name,
        'pic': _pic,
        'time': DateTime.now().millisecondsSinceEpoch
      });
    });
  }

//  profile(BuildContext context) {
//    Route route = MaterialPageRoute(builder: (context) => Profile());
//    Navigator.push(context, route);
//  }

//  initPlatformState() async {
//
//    Location _location = Location();
//    bool _permission = false;
//    String error;
//
//    Map<String, double> location;
//    _permission = await _location.hasPermission();
//    location = await _loc
//    if(location!=null){
//      String url =location['latitude'].toString()+'@'+location['longitude'].toString();
//          sendMsg('location', 'location', url);
//    }
//    print(location);
//
//  }


SharedPreferences sharedPreferences;

  getCredential() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _name = sharedPreferences.getString("name");
      _email = sharedPreferences.getString("email");
      _pic = sharedPreferences.getString("pic");
    });
  }
}

// single message template---------------------//

