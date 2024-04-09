import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Project_opal/chat.dart';
import 'package:Project_opal/map.dart';
import 'map.dart';

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
      initialIndex: 2,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  void _addFriend(String friendName) async {
    if (friendName.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('friends').add({
          'name': friendName,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Friend added successfully')),
        );
      } catch (e) {
        print('Error adding friend: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add friend')),
        );
      }
    }
  }

  void _deleteFriend(String friendId) async {
    try {
      await FirebaseFirestore.instance
          .collection('friends')
          .doc(friendId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Friend deleted successfully')),
      );
    } catch (e) {
      print('Error deleting friend: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete friend')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Image.asset(
            'lib/assets/com.png',
            height: 78,
          ),
          backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
        ),
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
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) {
                        _addFriend(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Search Friends',
                        suffixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('friends')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final List<DocumentSnapshot> friends = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: friends.length,
                      itemBuilder: (context, index) {
                        final friendName = friends[index]['name'];
                        final friendId =
                            friends[index].id; // Get the document ID
                        return ListTile(
                          title: Text(friendName),
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(),
                                  ));
                            },
                            child: CircleAvatar(
                              child: Text(friendName[0]),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteFriend(
                                  friendId); // Call delete function on button press
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "DinoCom",
        labels: const [
          "DinoReads",
          "DinoSearch",
          "DinoCom",
          "DinoMap",
          "DinoGoal"
        ],
        icons: const [
          Icons.book,
          Icons.search,
          Icons.people,
          Icons.map,
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
          if (value == 0) {
            Navigator.pushNamed(context, '/main2');
          } else if (value == 1) {
            Navigator.pushNamed(context, '/dinoSearch');
          } else if (value == 3) {
            Navigator.pushNamed(context, '/profile');
          } else if (value == 4) {
            Navigator.pushNamed(context, '/dinogoal');
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
