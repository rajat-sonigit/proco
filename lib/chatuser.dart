import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proco/chats.dart';

class ChatUser extends StatelessWidget {
  const ChatUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chats")),
      body: _buildUserList(context), // Pass context here
    );
  }

  Widget _buildUserList(BuildContext context) {
    // Receive context here
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) =>
                    _buildUserListItem(context, doc)) // Pass context here
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(BuildContext context, DocumentSnapshot document) {
    // Receive context here
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    final _auth = FirebaseAuth.instance;
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chats(
                        receiverUserEmail: data['email'],
                        receiverUserId: data['uid'],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
