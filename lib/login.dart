
import 'package:flutter/material.dart';
import 'main2.dart'; 
import 'main3.dart'; 
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    home: LoginScreen(),
    routes: {
      '/main2': (context) => Main2Screen(), 
      '/main3': (context) => MyApp(), 
    },
  ));
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/bg.png"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView( 
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 60),
                 
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Welcome !',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Sign in',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 40),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'User name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(value: false, onChanged: (bool? value) {}),
                                Text('Remember me'),
                              ],
                            ),
                            TextButton(
                              child: Text('Forgot Password?'),
                              onPressed: () {
                                // Add forgot password logic 
                              },
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor, 
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          ),
                          child: Text('Login'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/main2');
                          },
                        ),
                        TextButton(
                          child: Text('Don\'t have an Account? Register'),
                          onPressed: () {
                            Navigator.pushNamed(context, '/main3');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60), 
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

