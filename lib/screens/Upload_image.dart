import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

int count = 1;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File sampleImage;

  Future getimage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
    uploadImage();
  }

  Widget uploadImage() {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Image.file(sampleImage),
            SizedBox(height: 50.0,),
            RaisedButton(
              padding: EdgeInsets.only(left: 40.0,right: 40.0),
              elevation: 70,
              child: Text('UPLOAD'),
              onPressed: () {
                FirebaseStorage.instance
                    .ref()
                    .child('lol$count')
                    .putFile(sampleImage);
                count++;
                Navigator.pushNamed(context, 'home');
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: sampleImage == null
              ? FlatButton(
                  padding: EdgeInsets.only(
                      left: 40.0, right: 40.0, top: 14.0, bottom: 12.0),
                  color: Colors.blue,
                  child: Text(
                    'Select Image',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: getimage,
                )
              : uploadImage(),
        ),
      ),
    );
  }
}
