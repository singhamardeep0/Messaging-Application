import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

FirebaseUser loggedInUser;
class Messagepage extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}



class _MessageState extends State<Messagepage> {
  final _fireStore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  File sampleImage;
  int _selectedIndex = 1;


  @override
  void initState() {
    // TODO: implement initState
    getCurrentUser();
  }
  void getCurrentUser() async {
    try {
      final user1 = await _auth.currentUser();
      if (user1 != null) {
        loggedInUser = user1;
      }
    } catch (e) {
      print(e);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, 'friend');
      }
      if(index == 2) {
        Navigator.pushNamed(context, 'uploadimage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: Icon(Icons.arrow_back,color: Colors.black,), onPressed: (){Navigator.pushNamed(context, 'friend');}  ),
        backgroundColor: Colors.teal,
        title: Text(
          'Friends',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
      ),
      backgroundColor: Colors.white,



      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('friendsof'+loggedInUser.email).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final users = snapshot.data.documents;
          final currentUser = loggedInUser.email;
          List<Container> uwidgets = [];

          for (var variable in users) {

            final user = variable.data['user'];
            final username = variable.data['username'];

            final res = currentUser+user;
            final res2 = user+currentUser;

            final uw = Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.0),
                color: Colors.black12,
              ),
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.people,
                    ),
                  ),
                  FlatButton(
                    onLongPress: (){
                      _fireStore.collection('friendsof'+loggedInUser.email).document(user).delete();
                      print('shut');
                    },
                    onPressed: (){

                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChatScreen(res,res2)));

                    },
                    child: Text(
                      username.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            );
            uwidgets.add(uw);
          }
          return ListView(
            padding: EdgeInsets.all(10.0),
            children: uwidgets,
          );
        },
      ),


      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text(
              'Search',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            icon: Icon(
              Icons.search,
              size: 30.0,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              size: 30.0,
            ),
            title: Text(
              'Messages',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              size: 30.0,
            ),
            title: Text(
              'Upload',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),

    );


  }
}

