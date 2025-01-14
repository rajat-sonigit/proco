import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:proco/home_page.dart';

class ProfileCreationPag extends StatefulWidget {
  const ProfileCreationPag({Key? key}) : super(key: key);

  @override
  _ProfileCreationPageState createState() => _ProfileCreationPageState();
}
class _ProfileCreationPageState extends State<ProfileCreationPag> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  List<String> selectedKeywords = [];
  File? _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _profiles =
      FirebaseFirestore.instance.collection('profiles');

  List<String> allKeywords = [
    'Android Development',
    'Artificial Intelligence',
    'Biology',
    'Chemistry',
    'Coding',
  ];

  void _toggleKeyword(String keyword) {
    setState(() {
      if (selectedKeywords.contains(keyword)) {
        selectedKeywords.remove(keyword);
      } else {
        if (selectedKeywords.length < 10) {
          selectedKeywords.add(keyword);
        } else {
        }
      }
    });
  }

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadImage() async {
    try {
      if (_image == null) {
        print('No image selected.');
        return;
      }

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference reference =
          storage.ref().child("profileImages/${_auth.currentUser!.uid}");

      await reference.putFile(_image!);
      String imageUrl = await reference.getDownloadURL();
      await _createProfile(imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Future<void> _createProfile(String imageUrl) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Get the user input values
        String name = _nameController.text;
        String age = _ageController.text;
        Map<String, dynamic> profileData = {
          'name': name,
          'age': age,
          'keywords': selectedKeywords,
          'imageUrl': imageUrl,
        };

        // Push profile data to Firestore
        await _profiles.doc(user.uid).set(profileData);

        // Navigate to HomePage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage(name: "")),
        );
      }
    } catch (e) {
      print('Error creating profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCE4EC),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Lottie.network(
                'https://lottie.host/7ba94f3e-9aa7-4ee4-a2a9-b75e6a324dc2/zqK2KupRxa.json',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Create Your Profile',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(
                hintText: 'Age',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImage,
              child: Text(
                'Upload Image',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 20)),
              ),
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                _showKeywordsDialog(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Keywords',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Create Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void _showKeywordsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFE4EC),
          title: Text(
            'Select Keywords',
            style: TextStyle(fontSize: 20, color: Colors.deepPurple),
          ),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: allKeywords.map((keyword) {
                return FilterChip(
                  label: Text(
                    keyword,
                    style: TextStyle(
                        color: selectedKeywords.contains(keyword)
                            ? Colors.white
                            : Colors.black),
                  ),
                  selected: selectedKeywords.contains(keyword),
                  onSelected: (bool selected) {
                    setState(() {
                      _toggleKeyword(keyword);
                    });
                  },
                  backgroundColor: selectedKeywords.contains(keyword)
                      ? Colors.deepPurple
                      : Colors.transparent,
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Done',
                style: TextStyle(color: Colors.deepPurple, fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<File>('image', _image ?? File('')));
  }
}
