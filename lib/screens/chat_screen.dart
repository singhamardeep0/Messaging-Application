import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  final String res;
  final String res2;
  ChatScreen(this.res,this.res2);
  @override
  _ChatScreenState createState() => _ChatScreenState(res,res2);
}

class _ChatScreenState extends State<ChatScreen> {

  String res;
  String res2;
  _ChatScreenState(this.res,this.res2);
  @override

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String message;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: Text('⚡️Chat'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection(res).snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data.documents.reversed;

                List<MessageBubble> mwidgets = [];

                for (var message in messages) {
                  final mtext = message.data['text'];
                  final msender = message.data['sender'];

                  final currentUser = loggedInUser.email;

                  final mw = MessageBubble(
                    sender : msender,
                    text: mtext,
                    isMe : currentUser == msender,
                  );
                  mwidgets.add(mw);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: EdgeInsets.all(10.0),
                    children: mwidgets,
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                border: Border.all( color: Colors.grey,),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                  )
                ],
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      _fireStore.collection(res).document(DateTime.now().toString()).setData({'text': message, 'sender': loggedInUser.email});
                      _fireStore.collection(res2).document(DateTime.now().toString()).setData({'text': message, 'sender': loggedInUser.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




 class MessageBubble extends StatelessWidget {

  MessageBubble({this.sender,this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;
   @override
   Widget build(BuildContext context) {
     return Padding(
       padding:  EdgeInsets.all(10.0),
       child: Column(
         crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
         children: <Widget>[
           Text(
               sender,
             style: TextStyle(
               fontSize: 10.0,
               color: Colors.black,
             ),
           ),
           Material(
             borderRadius: isMe ? BorderRadius.only(
                 topLeft: Radius.circular(30.0),
                 bottomRight: Radius.circular(30.0),
                 bottomLeft: Radius.circular(30.0) ):
             BorderRadius.only(
               topRight: Radius.circular(30.0),
               bottomRight: Radius.circular(30.0),
               bottomLeft: Radius.circular(30.0) ),

             elevation: 5.0,
             color: isMe ? Colors.lightBlueAccent : Colors.green,
             child: Padding(
               padding:  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
               child: Text(
                  text,
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 18.0,
                 ),
               ),
             ),
           ),
         ],
       ),
     );
   }
 }
