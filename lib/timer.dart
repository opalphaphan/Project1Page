// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:motion_tab_bar/MotionBadgeWidget.dart';
// import 'package:motion_tab_bar/MotionTabBar.dart';
// import 'package:motion_tab_bar/MotionTabBarController.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dino Timer',
//       theme: ThemeData(
//         textTheme: GoogleFonts.poppinsTextTheme(),
//         primarySwatch: Colors.blue,
//       ),
//       home: TimerPage(),
//     );
//   }
// }

// class TimerPage extends StatefulWidget {
//   @override
//   _TimerPageState createState() => _TimerPageState();
// }

// class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
//   late MotionTabBarController _motionTabBarController;
//   Timer? _timer;
//   int _seconds = 0;
//   List<String> _recordedTimes = [];

//   @override
//   void initState() {
//     super.initState();

//     _motionTabBarController = MotionTabBarController(
//       initialIndex: 1,
//       length: 5,
//       vsync: this,
//     );
//   }

//   void _startTimer() {
//     if (_timer != null && _timer!.isActive) return;
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         _seconds++;
//       });
//     });
//   }

//   void _stopTimer() {
//     _timer?.cancel();
//   }

//   void _restartTimer() {
//     _stopTimer();
//     setState(() {
//       _seconds = 0;
//     });
//   }

//   void _recordTime() {
//     setState(() {
//       _recordedTimes.add(_formatTime(_seconds));
//     });
//   }

//   String _formatTime(int totalSeconds) {
//     int minutes = totalSeconds ~/ 60;
//     int seconds = totalSeconds % 60;
//     return minutes.toString().padLeft(2, '0') +
//         ':' +
//         seconds.toString().padLeft(2, '0');
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PreferredSize(
//       preferredSize: Size.fromHeight(90.0), 
//       child: AppBar(
//         title: Image.asset(
//           'lib/assets/dinotimer.png', 
//           height: 80, 
//         ),
//         backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
//       ),
//     ),

//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'lib/assets/bg.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 _formatTime(_seconds),
//                 style: TextStyle(fontSize: 50),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: _startTimer,
//                     child: Text('Start'),
//                   ),
//                   SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: _stopTimer,
//                     child: Text('Stop'),
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                   ),
//                   SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: _restartTimer,
//                     child: Text('Restart'),
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.yellow),
//                   ),
//                   SizedBox(width: 20),
//                   ElevatedButton(
//                     onPressed: _recordTime,
//                     child: Text('Record'),
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.green),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _recordedTimes.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title:
//                           Text('Record ${index + 1}: ${_recordedTimes[index]}'),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 20,
//             left: 20,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: MotionTabBar(
//         controller: _motionTabBarController,
//         initialSelectedTab: "DinoGoal",
//         labels: const [
//           "DinoReads",
//           "DinoSearch",
//           "DinoMap",
//           "Profile",
//           "DinoGoal"
//         ],
//         icons: const [
//           Icons.book,
//           Icons.search,
//           Icons.map,
//           Icons.people,
//           Icons.flag
//         ],
//         tabSize: 50,
//         tabBarHeight: 55,
//         textStyle: const TextStyle(
//           fontSize: 12,
//           color: Colors.black,
//           fontWeight: FontWeight.w500,
//         ),
//         tabIconColor: Colors.blue[600],
//         tabIconSize: 28.0,
//         tabIconSelectedSize: 26.0,
//         tabSelectedColor: Colors.blue[900],
//         tabIconSelectedColor: Colors.white,
//         tabBarColor: Colors.white,
//         onTabItemSelected: (int value) {
//           if (value == 1) {
//             Navigator.pushNamed(
//               context,
//               '/dinoSearch',
//             );
//           } else if (value == 0) {
//             Navigator.pushNamed(context, '/main2');
//           } else if (value == 3) {
//             Navigator.pushNamed(context, '/profile');
//           } else if (value == 2) {
//             Navigator.pushNamed(
//               context,
//               '/dinocom',
//             );
//           } else if (value == 4) {
//             Navigator.pushNamed(
//               context,
//               '/dinogoal',
//             );
//           } else {
//             // Handle other tab selections
//           }
//         },
//         badges: [
//           const MotionBadgeWidget(
//             text: '10+',
//             textColor: Colors.white,
//             color: Color.fromARGB(255, 240, 159, 153),
//             size: 18,
//           ),
//           Container(
//             color: Colors.black,
//             padding: const EdgeInsets.all(2),
//           ),
//           null,
//           const MotionBadgeWidget(
//             isIndicator: true,
//             color: Colors.blue,
//             size: 7,
//             show: true,
//           ),
//           null,
//         ],
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Timer',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  Timer? _timer;
  int _seconds = 0;
  List<String> _recordedTimes = [];

  @override
  void initState() {
    super.initState();
  }

  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _restartTimer() {
    _stopTimer();
    setState(() {
      _seconds = 0;
    });
  }

  void _recordTime() {
    String formattedTime = _formatTime(_seconds);

    FirebaseFirestore.instance.collection('recorded_times').add({
      'time': formattedTime,
      'timestamp': DateTime.now(),
    }).then((value) {
      setState(() {
        _recordedTimes.add(formattedTime);
      });
    }).catchError((error) {
      print("Failed to add record: $error");
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return minutes.toString().padLeft(2, '0') +
        ':' +
        seconds.toString().padLeft(2, '0');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dino Timer'),
        backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _formatTime(_seconds),
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _startTimer,
                    child: Text('Start'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _stopTimer,
                    child: Text('Stop'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _restartTimer,
                    child: Text('Restart'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _recordTime,
                    child: Text('Record'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('recorded_times')
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    List<QueryDocumentSnapshot> documents =
                        snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        var record = documents[index];
                        return ListTile(
                          title: Text(
                              'Record ${index + 1}: ${record['time']}'),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordHistoryScreen()),
                );
              },
              child: Text('View History'),
            ),
          ],
        ),
      ),
    );
  }
}

class RecordHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record History'),
        backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('recorded_times').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var record = documents[index];
              return ListTile(
                title: Text('Record ${index + 1}: ${record['time']}'),
              );
            },
          );
        },
      ),
    );
  }
}
