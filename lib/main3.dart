
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'summary.dart';
// import 'main3.dart'; // Import your main3.dart file
// import 'main2.dart'; // Import your main2.dart file

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'DinoReads Sign Up',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.poppinsTextTheme(),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: SignUpScreen(),
//       routes: {
//         '/main2': (context) => Main2Screen(), // Ensure this matches your navigation call
//         '/summary': (context) => SummaryPage(userData: {}),
//       },
    
//     );
//   }
// }

// class SignUpScreen extends StatelessWidget {
//   final TextEditingController _fullnameController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('lib/assets/bg.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Container(
//                 padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 6.0,
//                       offset: Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Text(
//                       'Welcome !\nSign up to Dinoreads',
//                       style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
//                       textAlign: TextAlign.left,
//                     ),
//                     SizedBox(height: 20),
//                     Image.asset(
//                       'lib/assets/dino.png',
//                       height: 120,
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: _fullnameController,
//                       decoration: InputDecoration(
//                         labelText: 'Fullname',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: _usernameController,
//                       decoration: InputDecoration(
//                         labelText: 'Username',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       controller: _emailController,
//                       decoration: InputDecoration(
//                         labelText: 'Email',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 16),
//                     TextField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         labelText: 'Confirm Password',
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//                     SizedBox(height: 24),
//                     ElevatedButton(
//                       child: Text('Register'),
//                       onPressed: () {
//                         final userData = {
//                           'fullname': _fullnameController.text,
//                           'username': _usernameController.text,
//                           'email': _emailController.text,
//                         };
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => SummaryPage(userData: userData)),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.pink,
//                         onPrimary: Colors.white,
//                       ),
//                     ),
//                     TextButton(
//                       child: Text('Already have an Account ? Login'),
//                       onPressed: () {
//                         // Navigate to login screen
//                       },
//                       style: TextButton.styleFrom(
//                         primary: Colors.blue,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'summary.dart';
import 'main2.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DinoReads Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUpScreen(),
      routes: {
        '/main2': (context) => Main2Screen(),
        '/summary': (context) => SummaryPage(userData: {}),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? _image;
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Welcome !\nSign up to Dinoreads',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                     SizedBox(height: 20),
                    Image.asset(
                      'lib/assets/dino.png',
                      height: 120,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 203, 227, 239),
                        backgroundImage: _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.add_a_photo, size: 60, color: Colors.white)
                            : null,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _fullnameController,
                      decoration: InputDecoration(
                        labelText: 'Fullname',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      child: Text('Register'),
                      onPressed: () {
                        final userData = {
                          'fullname': _fullnameController.text,
                          'username': _usernameController.text,
                          'email': _emailController.text,
                          'profilePicture': _image,
                        };
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SummaryPage(userData: userData)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 227, 142, 170),
                        foregroundColor: Colors.white,
                      ),
                    ),
                    TextButton(
                      child: Text('Already have an Account ? Login'),
                      onPressed: () {
                         Navigator.pushNamed(context, '/login');
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 63, 158, 235),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
