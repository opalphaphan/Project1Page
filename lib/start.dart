
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/firebase_options.dart';
import 'login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main3.dart'; 

Future<void> main() async {

   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(MyAppstart());
  
}

class MyAppstart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dino Reads',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Positioned.fill(
            child: Image.asset(
              'lib/assets/start.png', 
              fit: BoxFit.cover,
            ),
          ),
          // Sign In Button with blue circular background
          Positioned(
            bottom: 50.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>MyApp()), 
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(255, 15, 81, 136), 
                  ),
                  padding: EdgeInsets.all(18.0), 
                  child: Ink(
                    decoration: BoxDecoration(

                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                      child: Text('Get Start!', style: TextStyle(fontSize: 16.0, color: Colors.white,),),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
