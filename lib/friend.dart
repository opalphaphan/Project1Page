import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:motion_tab_bar/MotionTabItem.dart';
import 'package:motion_tab_bar/helpers/HalfClipper.dart';
import 'package:motion_tab_bar/helpers/HalfPainter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'summary.dart';
import 'main2.dart';
import 'main3.dart';
import 'main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DinoReads',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: DinoCom(),
      routes: {
      },
    );
  }
}

class DinoCom extends StatefulWidget {
  @override
  _DinoComState createState() => _DinoComState();
}

class _DinoComState extends State<DinoCom> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  Widget _buildListItem(String name, String imagePath, IconData statusIcon) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(imagePath),
          ),
          title: Text(name),
          trailing: Icon(statusIcon),
          onTap: () {
            // Handle the tap
          },
        ),
        SizedBox(height: 15),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DINO Community', style: GoogleFonts.poppins()),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search Friends',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildListItem('SeunghanRiize', 'lib/assets/Seunghan.jpg', Icons.people),
                  _buildListItem('SungchanRiize', 'lib/assets/Sungchan.jpg', Icons.people),
                  _buildListItem('ShotaroRiize', 'lib/assets/Shotaro.jpg', Icons.people),
                  _buildListItem('SoheeRiize', 'lib/assets/Sohee.jpg', Icons.people),
                  _buildListItem('EunseokRiize', 'lib/assets/Eunseok.jpg', Icons.people),
                  _buildListItem('WonbinRiize', 'lib/assets/Wonbin.jpg', Icons.people),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "DinoMap",
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
          if (value == 1) {
            // Assuming the DinoSearch tab is at index 1
            Navigator.pushNamed(
              context, '/dinoSearch'); // Navigate to DinoSearch page
            } else if (value == 0) {
              Navigator.pushNamed(context, '/main2');
            } else if (value == 3) {
              Navigator.pushNamed(context, '/profile');
            } else if (value == 2) {
              Navigator.pushNamed(context, '/dinocom');
              // Navigate to Userpage (data.dart)
            } else if (value == 4) {
              Navigator.pushNamed(context, '/dinogoal');
            } else {
              // Handle other tab selections
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
    );
  }
}
