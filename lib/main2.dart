import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'book.dart';
import 'timer.dart';

class Main2Screen extends StatefulWidget {
  @override
  _Main2ScreenState createState() => _Main2ScreenState();
}

class _Main2ScreenState extends State<Main2Screen>
    with TickerProviderStateMixin {
  late User _user;
  MotionTabBarController? _motionTabBarController;
  Map<String, dynamic>?
      _selectedQuoteData; // Variable to store selected quote data

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser!;
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
         backgroundColor: Color.fromRGBO(255, 255, 255, 1),
         appBar: PreferredSize(
      preferredSize: Size.fromHeight(80), 
      
      child: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Padding(
            padding: EdgeInsets.only(top: 1),
        child: Image.asset(
          'lib/assets/dnr.png', 
          height: 270, 
          width: 320,
          // fit: BoxFit.fitWidth,
        ),
        ),
      ),
    ),
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
    Text(
      'Welcome back! ${_user.email}',
      style: TextStyle(fontSize: 18),
    ),
    GestureDetector(
      onTap: () {
        // Navigate to the desired page here
        Navigator.pushNamed(context, '/temp');
      },
      child: CircleAvatar(
            radius: 20, 
            child: Icon(
              Icons.person,
              size: 30, 
              color: Colors.white, 
            ),
            backgroundColor: Colors.blue,
          ),
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TimerPage(),
                                ));
                          },
                          child: Text('Start!'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (_selectedQuoteData != null) ...[
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          // Quote Section
                          Text(
                            "'${_selectedQuoteData!['quote']}'",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "--- By ${_selectedQuoteData!['author']} ---",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                  // Bottom section with Trends and Dino Communities
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'lib/assets/dn.png',
                        height: 200,
                        width: 200,
                    
                      ),
                      // Column(
                      //   children: [
                      //     Image.asset(
                      //       'lib/assets/dn.png',
                      //       height: 60,
                      //       width: 60,
                      //     ),
                      //     // Text('Find out Trends'),
                      //   ],
                      // ),
                      // Column(
                      //   children: [
                      //     Image.asset(
                      //       'lib/assets/3.png',
                      //       height: 60,
                      //       width: 60,
                      //     ),
                      //     Text('Dino Communities'),
                      //   ],
                      // ),
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
            setState(() {
              _motionTabBarController!.index = value;
            });
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigate to AddQuotePage and get selected quote data
            final selectedQuoteData = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddQuotePage()),
            );
            // Update state with selected quote data
            setState(() {
              _selectedQuoteData = selectedQuoteData;
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

// ADD QUOTE PAGE TEMPORARY PLACE
class AddQuotePage extends StatelessWidget {
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void _addQuote(BuildContext context) async {
    if (_quoteController.text.isNotEmpty && _authorController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('quotes').add({
        'quote': _quoteController.text,
        'author': _authorController.text,
        'date': DateTime.now(),
      });
      // Clear text fields after adding the quote
      _quoteController.clear();
      _authorController.clear();
      // Refresh the stream to update the list of quotes
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Quote added successfully'),
        duration: Duration(seconds: 2),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter both quote and author'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
 return Scaffold(
  appBar: PreferredSize(
    preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/Dinochat.png',
                height: 80, // Adjust the height as needed
              ),
              SizedBox(width: 10), // Add spacing between the image and text

            ],
          ),
           backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quoteController,
                    decoration: InputDecoration(labelText: 'Enter Quote'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _authorController,
                    decoration: InputDecoration(labelText: 'Enter Author Name'),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _addQuote(context),
                  child: Text('Add Quote'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('quotes').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final quoteData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      return ListTile(
                        title: Text(quoteData['quote']),
                        subtitle: Text('- ${quoteData['author']}'),
                        onTap: () {
                          Navigator.pop(context,
                              quoteData); // Pass the selected quote data back to the previous screen
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Delete the selected quote from Firestore
                            FirebaseFirestore.instance
                                .collection('quotes')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
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
    );
  }
}
