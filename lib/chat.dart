import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat UI',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<Message> messages = [];
  final TextEditingController textEditingController = TextEditingController();

  void _sendMessage() {
    final text = textEditingController.text;
    if (text.trim().isNotEmpty) {
      setState(() {
        messages.add(Message(text, DateTime.now(), isSender: true));
        textEditingController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chat room'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              // More actions
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) => MessageBubble(message: messages[messages.length - index - 1]),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: 'Send a message',
                        border: InputBorder.none,
                        filled: true,
                        fillColor: Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  String text;
  DateTime timestamp;
  bool isSender;
  Message(this.text, this.timestamp, {this.isSender = false});
}

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bubbleAlign = message.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = message.isSender ? Colors.blue[200] : Colors.grey[200];
    final textColor = message.isSender ? Colors.white : Colors.black87;
    final timeFormat = DateFormat('hh:mm a');
    final messageTime = timeFormat.format(message.timestamp);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: bubbleAlign,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
          SizedBox(height: 4),
          Text(
            messageTime,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 10,
            ),
          )
        ],
      ),
    );
  }
}
