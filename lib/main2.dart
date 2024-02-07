
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('../lib/assets/bg.png'), // Replace with your background image asset
              fit: BoxFit.cover, // This will fill the background of the Container
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
            children: <Widget>[
              // Welcome and user profile section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Welcome back! Lee Anton'),
                  CircleAvatar(
                    backgroundImage: AssetImage('../lib/assets/anton.jpg'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Clock image and reading level progress
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                  
                ),
                child: Column(
                  
                  children: [
                    Image.asset('../lib/assets/2.png',height: 60,width: 60,),
                    Text('Continue to reach Level 5'),
                    Text('Start your read now'),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Start!'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  
                ),
                child: Column(
                  
                  children: [
              // Quote Section
              Text('20, January, 2024'),
              Text('“With freedom, books, flowers, and the moon, who could not be happy?”'),
              Text('-Oscar Wilde-'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {},
              ),
              SizedBox(height: 8),
                  ]
                ),
              ),
              
              // Bottom section with Trends and Dino Communities
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset('../lib/assets/1.png',height: 60,width: 60,),
                  Column(
                    children: [
                      Image.asset('../lib/assets/4.png',height: 60,width: 60,),
                      Text('Find out Trends'),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('../lib/assets/3.png',height: 60,width: 60,),
                      Text('Dino Communities'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
