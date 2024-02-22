import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'data.dart';

class Main2Screen extends StatefulWidget {
  @override
  _Main2ScreenState createState() => _Main2ScreenState();
}

class _Main2ScreenState extends State<Main2Screen> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/bg.png'),
                fit: BoxFit.cover,
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
                        backgroundImage: AssetImage('lib/assets/anton.jpg'),
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
                        Image.asset(
                          'lib/assets/2.png',
                          height: 60,
                          width: 60,
                        ),
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
                        Text(
                          '“With freedom, books, flowers, and the moon, who could not be happy?”',
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                  // Bottom section with Trends and Dino Communities
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'lib/assets/1.png',
                        height: 60,
                        width: 60,
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'lib/assets/4.png',
                            height: 60,
                            width: 60,
                          ),
                          Text('Find out Trends'),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'lib/assets/3.png',
                            height: 60,
                            width: 60,
                          ),
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
        bottomNavigationBar: MotionTabBar(
          controller: _motionTabBarController,
          initialSelectedTab: "DinoReads",
          labels: const [
            "DinoReads",
            "DinoSearch",
            "DinoMap",
            "Profile",
            "DinoGoal"
          ],
          icons: const [
            Icons.book,
            Icons.search,
            Icons.map,
            Icons.people,
            Icons.flag
          ],
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          tabIconColor: Colors.blue[600],
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor: Colors.blue[900],
          tabIconSelectedColor: Colors.white,
          tabBarColor: Colors.white,
          onTabItemSelected: (int value) {
            setState(() {
              _motionTabBarController!.index = value;
            });
            if (value == 1) {
              // Assuming the DinoSearch tab is at index 1
              Navigator.pushNamed(context, '/dinoSearch');
            } else if (value == 3) {
              Navigator.pushNamed(context, '/profile');
            }
          },
          badges: [
            const MotionBadgeWidget(
              text: '10+',
              textColor: Colors.white,
              color: Color.fromARGB(255, 240, 159, 153),
              size: 18,
            ),
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(2),
            ),
            null,
            const MotionBadgeWidget(
              isIndicator: true,
              color: Colors.blue,
              size: 7,
              show: true,
            ),
            null,
          ],
        ),
      ),
    );
  }
}
