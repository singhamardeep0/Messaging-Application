import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


FirebaseUser loggedInUser;
final _fireStore = Firestore.instance;

class Friends extends StatefulWidget {
  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;

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
      if (index == 1) {
        Navigator.pushNamed(context, 'mes');
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
        backgroundColor: Colors.teal,
        title: Text('USERS'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          ),
        ],
      ),


      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('users').snapshots(),
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

            final res = currentUser + user;
            final res2 = user + currentUser;

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
                    onPressed: () async {
                      await _fireStore.collection('friendsof'+loggedInUser.email).document(user).setData({ 'user': user, 'username' : username});
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ChatScreen(res, res2)));
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

class DataSearch extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search for users.....';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.teal,
      primaryIconTheme: theme.primaryIconTheme,
      primaryColorBrightness: theme.primaryColorBrightness,
      primaryTextTheme: theme.primaryTextTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        color: Colors.black,
        onPressed: () {
          query = null;
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {}

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('users').snapshots(),
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
            String usern = username.toString();

            final res = currentUser + user;
            final res2 = user + currentUser;

            if (query.isEmpty) {
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
                      onPressed: () async {
                        await _fireStore.collection('friendsof'+loggedInUser.email).document(user).setData({ 'user': user, 'username' : username});
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChatScreen(res, res2)));

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
            else if (usern.startsWith(query)) {
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
                      onPressed: () async {
                        await _fireStore.collection('friendsof'+loggedInUser.email).document(user).setData({ 'user': user, 'username' : username});
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ChatScreen(res, res2)));
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
          }
          return ListView(
            padding: EdgeInsets.all(10.0),
            children: uwidgets,
          );
        },
      ),
    );
  }
}
