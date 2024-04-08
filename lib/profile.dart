
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profile Page',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         textTheme: GoogleFonts.poppinsTextTheme(),
//       ),
//       home: ProfilePage(),
//     );
//   }
// }

// class ProfilePage extends StatefulWidget {
//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   String bio =
//       "briize? did you enjoy today's\nas soon as i saw briize today, i felt so happy hehe\nso i think i’m comfortable inside. that's what i thought\nthe cheers that i heard after a long time gave me...";

//   void _editBio(BuildContext context) {
//     TextEditingController _bioController = TextEditingController();
//     _bioController.text = bio;
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Edit Bio'),
//         content: TextField(
//           controller: _bioController,
//           maxLines: null,
//           keyboardType: TextInputType.multiline,
//           decoration: InputDecoration(
//             hintText: 'Enter your new bio here',
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               setState(() {
//                 bio = _bioController.text;
//               });
//               Navigator.of(context).pop();
//             },
//             child: Text('Save'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           width: double.infinity, 
//         height: double.infinity, 
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("lib/assets/bg.png"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Column(
//               children: <Widget>[
//                 SizedBox(height: 20),
//                 CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage('lib/assets/anton.jpg'),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   'WonbinRiize',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'wonbinriize@gmail.com',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     _buildButton(context, 'Edit'),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 _buildInfoSection('Level 7', 'Time Record : 220 min', 'Book Record : 7'),
//                 SizedBox(height: 20),
//                 _buildBioSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildButton(BuildContext context, String title) {
//     return ElevatedButton(
//       child: Text(title),
//       onPressed: () {
//         if (title == 'Edit') {
//           _editBio(context);
//         }
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(18.0),
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoSection(String level, String timeRecord, String bookRecord) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         children: <Widget>[
//           Text(level, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           Text(timeRecord, style: TextStyle(fontSize: 16)),
//           Text(bookRecord, style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }

//   Widget _buildBioSection() {
//     return Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 5,
//             blurRadius: 7,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Bio',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             bio,
//             style: TextStyle(fontSize: 15),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String bio =
      "briize? did you enjoy today's\nas soon as i saw briize today, i felt so happy hehe\nso i think i’m comfortable inside. that's what i thought\nthe cheers that i heard after a long time gave me...";

  void _editBio(BuildContext context) {
    TextEditingController _bioController = TextEditingController();
    _bioController.text = bio;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Bio'),
        content: TextField(
          controller: _bioController,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Enter your new bio here',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              setState(() {
                bio = _bioController.text;
              });
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          title: Image.asset(
            'lib/assets/profile.png',
            height: 70,
          ),
          backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('lib/assets/anton.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                'WonbinRiize',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'wonbinriize@gmail.com',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildButton(context, 'Edit'),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildInfoSection('Level 7', 'Time Record : 220 min', 'Book Record : 7'),
                      SizedBox(height: 20),
                      _buildBioSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add your functionality here
                },
                child: Text('Like'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your functionality here
                },
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add your functionality here
                },
                child: Text('Finish'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title) {
    return ElevatedButton(
      child: Text(title),
      onPressed: () {
        if (title == 'Edit') {
          _editBio(context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
    );
  }

  Widget _buildInfoSection(String level, String timeRecord, String bookRecord) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Text(level, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(timeRecord, style: TextStyle(fontSize: 16)),
          Text(bookRecord, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildBioSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bio',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            bio,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
