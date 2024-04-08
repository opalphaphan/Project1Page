import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'main2.dart';
import 'friend.dart';
import 'summary.dart';

void main() => runApp(ChatApp());

class ChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
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
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        messages.add(Message(text, DateTime.now(), isSentByMe: true));
        _controller.clear();
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
        String response = generateResponse(text);
        messages.add(Message(response, DateTime.now(), isSentByMe: false)); 
        });
      });
    }
  }

  String generateResponse(String receivedMessage) {
    String response = "";
    if (receivedMessage.toLowerCase() == 'hi' ||
        receivedMessage.toLowerCase() == 'hello') {
      response = "Hi there!";
    } else if (receivedMessage.toLowerCase().contains('library')) {
      response = "There's one at the back of ICT building";
    } else if (receivedMessage.toLowerCase().contains('join')) {
      response = "Sure. What time should I be there?";
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Image.asset(
            'lib/assets/Dinochat.png',
            height: 78,
          ),
        backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/friend');
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[messages.length - 1 - index];
                  return MessageBubble(message: message);
                },
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
                        controller: _controller,
                        onSubmitted: (_) => _sendMessage(),
                        decoration: InputDecoration.collapsed(
                            hintText: 'Send a message'),
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
      ),
    );
  }
}

class Message {
  String text;
  DateTime timestamp;
  bool isSentByMe;
  Message(this.text, this.timestamp, {this.isSentByMe = false});
}

class MessageBubble extends StatelessWidget {
  final Message message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final bubbleAlignment = message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = message.isSentByMe ? Colors.blue[200] : Colors.white;
    final textColor = message.isSentByMe ? Colors.white : Colors.black87;
    final bubbleMargin = message.isSentByMe ? EdgeInsets.only(left: 50.0, bottom: 10.0) : EdgeInsets.only(right: 50.0, bottom: 10.0);
    DateTime now = DateTime.now();
    String time = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: bubbleMargin,
      child: Column(
        crossAxisAlignment: bubbleAlignment,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 4), // Add spacing between message and time
                Text(
                   time,
                  style: const TextStyle(color: Colors.black38, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}