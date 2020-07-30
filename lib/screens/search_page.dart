//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//
//
//
//class Searching extends StatefulWidget {
//  @override
//  _SearchingState createState() => _SearchingState();
//}
//
//class _SearchingState extends State<Searching> {
//
//  String searchedUser;
//  final _fireStore = Firestore.instance;
//
//  int _selectedIndex = 1;
//  void _onItemTapped(int index) {
//    setState(() {
//      _selectedIndex = index;
//      if(index==0) {
//        Navigator.pushNamed(context, 'friends');
//      }
//    });
//  }
//
//
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: StreamBuilder<QuerySnapshot>(
//        stream: _fireStore.collection('users').snapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) {
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          }
//
//          final users = snapshot.data.documents;
//          List<Container> uwidgets = [];
//
//          for (var variable in users) {
//            final user = variable.data['username'];
//
//            final uw = Container(
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(40.0),
//                color: Colors.black12,
//              ),
//              padding: EdgeInsets.all(10.0),
//              margin: EdgeInsets.all(4.0),
//              child: FlatButton(
//                onPressed: () {
//                },
//                child: Text(
//                  user.toString(),
//                  style: TextStyle(color: Colors.black, fontSize: 20.0),
//                ),
//              ),
//            );
//            uwidgets.add(uw);
//          }
//          return ListView(
//            padding: EdgeInsets.all(10.0),
//            children: uwidgets,
//          );
//        },
//      ),
//      bottomNavigationBar: BottomNavigationBar(
//        backgroundColor: Colors.red,
//        items: <BottomNavigationBarItem>[
//          BottomNavigationBarItem(
//            title: Text('Search', style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold),),
//            icon: Icon(Icons.search, size: 30.0,),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.message, size: 30.0, ),
//            title: Text('Messages', style:  TextStyle( color: Colors.black, fontWeight: FontWeight.bold),),
//          ),
//        ],
//
//        currentIndex: _selectedIndex,
//        selectedItemColor: Colors.white,
//        onTap: _onItemTapped,
//      ),
//    );
//  }
//}
