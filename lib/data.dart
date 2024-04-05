import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:project/firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     print("Firebase initialization error: $e");
//   }
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {

  MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        // useMaterial3: true, // Uncomment this line if useMaterial3 is supported
      ),
      home: const Userpage(title: 'Flutter Demo Home Page'),
    );
  }
}

class Userpage extends StatefulWidget {
  const Userpage({super.key, this.title = 'Default Title'});

  final String title;

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> with TickerProviderStateMixin {
  late MotionTabBarController _motionTabBarController;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("userData").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            print('Firestore Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data?.docs.length ?? 0,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = snapshot.data!.docs[index];
              final age = document['age'];
              final name = document['name'];
              final hobby = document['hobby'];

              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$age"),
                    Text("$name"),
                    Text("$hobby"),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Profile",
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