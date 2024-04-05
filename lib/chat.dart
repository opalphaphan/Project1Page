
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// import 'main2.dart'; 
// import 'summary.dart';
// import 'friend.dart';
// void main() => runApp(ChatApp());

// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat UI',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.poppinsTextTheme(),
//       ),
//       home: ChatScreen(),
//       routes: {
//         '/friend': (context) => MyApp(), 

//       },
//     );
//   }
// }

// class ChatScreen extends StatefulWidget {
//   @override
//   State createState() => ChatScreenState();
// }

// class ChatScreenState extends State<ChatScreen> {
//   final List<Message> messages = [];
//   final TextEditingController _controller = TextEditingController();

//   void _sendMessage() {
//     final text = _controller.text;
//     if (text.isNotEmpty) {
//       setState(() {
//         messages.add(Message(text, DateTime.now(), isSentByMe: true));
//         _controller.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent, 
//       appBar: AppBar(
//         title: Text('Chat room'),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_vert, color: Colors.black),
//             onPressed: () {
//               Navigator.pushNamed(context, '/friend');
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("lib/assets/bg.png"), 
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: ListView.builder(
//                 reverse: true,
//                 itemCount: messages.length,
//                 itemBuilder: (context, index) {
//                   final message = messages[messages.length - 1 - index];
//                   return MessageBubble(message: message);
//                 },
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 8.0),
//               color: Colors.white,
//               child: SafeArea(
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: TextField(
//                         controller: _controller,
//                         decoration: InputDecoration.collapsed(hintText: 'Send a message'),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.send, color: Colors.blue),
//                       onPressed: _sendMessage,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Message {
//   String text;
//   DateTime timestamp;
//   bool isSentByMe;
//   Message(this.text, this.timestamp, {this.isSentByMe = false});
// }

// class MessageBubble extends StatelessWidget {
//   final Message message;

//   MessageBubble({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     final bubbleAlignment = message.isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
//     final bubbleColor = message.isSentByMe ? Colors.blue[200] : Colors.white;
//     final textColor = message.isSentByMe ? Colors.white : Colors.black87;

//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: bubbleAlignment,
//         children: <Widget>[
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
//             decoration: BoxDecoration(
//               color: bubbleColor,
//               borderRadius: BorderRadius.circular(30.0),
//             ),
//             child: Text(
//               message.text,
//               style: TextStyle(color: textColor),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
