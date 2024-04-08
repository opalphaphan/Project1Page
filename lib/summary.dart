import 'dart:io';
import 'package:flutter/material.dart';
import 'main2.dart';

class SummaryPage extends StatelessWidget {
  final Map<String, dynamic> userData;

  SummaryPage({required this.userData});

  @override
  Widget build(BuildContext context) {
    final File? profilePicture = userData['profilePicture'] as File?;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Text('Fullname: ${userData['fullname']}'),
            Text('Username: ${userData['username']}'),
            Text('Email: ${userData['email']}'),
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

