import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMyMessage;
  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMyMessage,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isMyMessage ? Colors.blue[200] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Text(
        message,
        style: TextStyle(
          color: isMyMessage ? Colors.blue[900] : Colors.black,
        ),
      ),
    );
  }
}

class Chats extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserId;

  const Chats({
    Key? key,
    required this.receiverUserEmail,
    required this.receiverUserId,
  }) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late final Stream<QuerySnapshot> _messagesStream;
  @override
  void initState() {
    super.initState();
    _messagesStream = FirebaseFirestore.instance
        .collection('messages')
        .doc(widget.receiverUserId)
        .collection('chats')
        .orderBy('timestamp')
        .snapshots();
  }  
  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('messages')
            .doc(widget.receiverUserId)
            .collection('chats')
            .add({
          'senderId': currentUser.uid,
          'senderEmail': currentUser.email,
          'message': _messageController.text,
          'timestamp': Timestamp.now(),
        });
        _messageController.clear();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiverUserEmail)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final messages = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMyMessage =
                          message['senderId'] == _firebaseAuth.currentUser!.uid;
                      return ChatBubble(
                        message: message['message'],
                        isMyMessage: isMyMessage,
                      );
                    },
                  );
                }
              },
            ),
          ),       
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
