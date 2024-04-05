import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/book.dart';
import 'data.dart';
import 'firebase_options.dart';
import 'friend.dart';
import 'summary.dart';
import 'main2.dart';
import 'login.dart';
import 'timer.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      // Define routes for navigation
      routes: {
        '/': (context) => SignUpScreen(), // Home route
         '/main2': (context) => Main2Screen(),
        '/summary': (context) => SummaryPage(),
        '/login': (context) => LoginScreen(),
        '/dinoSearch': (context) => BookSearchPage(),
        '/profile': (context) => Userpage(),
        '/dinocom': (context) => DinoCom(),
        '/dinogoal': (context) => TimerPage(),
        '/main3': (context) => SignUpScreen(),
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
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void registerUser(BuildContext context) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Save additional user data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'fullname': _fullnameController.text,
        'username': _usernameController.text,
        'email': _emailController.text,
        // Add additional fields as needed
      });

      // Optionally, upload profile picture to Firebase Storage and save URL to Firestore

      // Navigate to the SummaryPage and pass the user data as arguments
      Navigator.pushNamed(context, '/summary', arguments: {
        'fullname': _fullnameController.text,
        'username': _usernameController.text,
        'email': _emailController.text,
        // Add additional fields as needed
      });
    } catch (e) {
      print('Error registering user: $e');
    }
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
                padding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: const [
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
                      'Welcome!\nSign up to DinoReads',
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color.fromARGB(255, 203, 227, 239),
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
                        child: _image == null
                            ? Icon(Icons.add_a_photo,
                                size: 60, color: Colors.white)
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
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => registerUser(context),
                      child: Text('Register'),
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
                        foregroundColor:
                            const Color.fromARGB(255, 63, 158, 235),
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

class SummaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Extract arguments passed from the SignUpScreen
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final File? profilePicture = args['profilePicture'] as File?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Summary Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Account', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: profilePicture != null ? FileImage(profilePicture) : null,
              child: profilePicture == null
                  ? Icon(Icons.person, size: 60, color: Colors.grey)
                  : null,
            ),
            SizedBox(height: 20),
            Text('Fullname: ${args['fullname']}'),
            Text('Username: ${args['username']}'),
            Text('Email: ${args['email']}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Edit'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/main2');
              },
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}