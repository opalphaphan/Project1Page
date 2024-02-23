
// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Dino Timer',
//       theme: ThemeData(
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

// class _TimerPageState extends State<TimerPage> {
//   Timer? _timer;
//   int _seconds = 0;
//   List<String> _recordedTimes = [];

//   void _startTimer() {
//     if (_timer != null && _timer!.isActive) return;
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         _seconds++;
//       });
//     });
//   }

//   void _stopTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
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
//     return minutes.toString().padLeft(2, '0') + ':' + seconds.toString().padLeft(2, '0');
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dino Timer'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.home),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('lib/assets/bg.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               _formatTime(_seconds),
//               style: TextStyle(fontSize: 50),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ElevatedButton(
//                   onPressed: _startTimer,
//                   child: Text('Start'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     elevation: 5.0,
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _stopTimer,
//                   child: Text('Stop'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     elevation: 5.0,
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _restartTimer,
//                   child: Text('Restart'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.yellow,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     elevation: 5.0,
//                   ),
//                 ),
//                 SizedBox(width: 20),
//                 ElevatedButton(
//                   onPressed: _recordTime,
//                   child: Text('Record'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20.0),
//                     ),
//                     elevation: 5.0,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _recordedTimes.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('Record ${index + 1}: ${_recordedTimes[index]}'),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class _TimerPageState extends State<TimerPage> {
  Timer? _timer;
  int _seconds = 0;
  List<String> _recordedTimes = [];

  void _startTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void _restartTimer() {
    _stopTimer();
    setState(() {
      _seconds = 0;
    });
  }

  void _recordTime() {
    setState(() {
      _recordedTimes.add(_formatTime(_seconds));
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return minutes.toString().padLeft(2, '0') + ':' + seconds.toString().padLeft(2, '0');
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
        backgroundColor: Color.fromARGB(255, 139, 221, 250),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/bg.png',
              fit: BoxFit.cover,
            ),
          ),
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _restartTimer,
                    child: Text('Restart'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _recordTime,
                    child: Text('Record'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _recordedTimes.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Record ${index + 1}: ${_recordedTimes[index]}'),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
