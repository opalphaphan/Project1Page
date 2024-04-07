import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:project/firebase_options.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Search App',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BookSearchPage(),
    );
  }
}

class BookSearchPage extends StatefulWidget {
  @override
  _BookSearchPageState createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage>
    with TickerProviderStateMixin {
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

  TextEditingController _controller = TextEditingController();
  List<Book> _books = [];

  Future<void> _searchBooks(String query) async {
    final response = await http
        .get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

    if (response.statusCode == 200) {
      setState(() {
        Iterable list = json.decode(response.body)['items'];
        _books = list.map((model) => Book.fromJson(model)).toList();
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  void _showBookDetails(Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BookDetailsPage(book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(0, 195, 231, 235),
        elevation: 0,
        title: Padding(
          padding:
              const EdgeInsets.all(10.0), // Add padding around the TextField
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              filled: true, // Add this line to enable filling the TextField
              fillColor: Color.fromARGB(
                  255, 139, 221, 250), // The fill color for the TextField
              hintText: 'Search books...',

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0), // Rounded corners
                borderSide: BorderSide.none, // No border
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _searchBooks(_controller.text);
                },
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/assets/search.png'), // Adjust the path as per your asset's location
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: _books.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: GestureDetector(
                onTap: () {
                  _showBookDetails(_books[index]);
                },
                child: Text(
                  _books[index].title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              subtitle: Text(_books[index].author),
            );
          },
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "DinoSearch",
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

class Book {
  late String id; // Volume ID
  late String title;
  late String author;
  String? description;
  String? imageUrl; // Cover image URL

  Book(
      {required this.id,
      required this.title,
      required this.author,
      this.description,
      this.imageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'];
    var authors = volumeInfo['authors'] as List<dynamic>?;
    var description = volumeInfo['description'];
    var id = json['id'];
    var imageLinks = volumeInfo['imageLinks'];

    return Book(
      id: id,
      title: volumeInfo['title'],
      author: authors != null ? authors.join(", ") : "Unknown Author",
      description: description,
      imageUrl: imageLinks != null
          ? imageLinks['thumbnail']
          : null, // Parsing cover image URL
    );
  }
}

class BookDetailsPage extends StatefulWidget {
  final Book book;

  BookDetailsPage(this.book);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  bool favoriteClicked = false;
  bool bookmarkClicked = false;
  bool checkClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.book.imageUrl !=
                null) // Display cover image if available
              Center(
                child: Image.network(
                  widget.book.imageUrl!,
                  width: 200,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      favoriteClicked = !favoriteClicked;
                    });
                  },
                  child: _buildCircleIcon(
                    Icons.favorite,
                    favoriteClicked ? Colors.white : Colors.blue,
                    Icons.favorite_border,
                    favoriteClicked ? Colors.blue : Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      bookmarkClicked = !bookmarkClicked;
                    });
                  },
                  child: _buildCircleIcon(
                    Icons.bookmark,
                    bookmarkClicked ? Colors.white : Colors.blue,
                    Icons.bookmark_border,
                    bookmarkClicked ? Colors.blue : Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      checkClicked = !checkClicked;
                    });
                  },
                  child: _buildCircleIcon(
                    Icons.check,
                    checkClicked ? Colors.white : Colors.blue,
                    Icons.check_box_outline_blank,
                    checkClicked ? Colors.blue : Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Author(s): ${widget.book.author}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.book.description ?? 'No description available',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircleIcon(
      IconData icon, Color color, IconData outlineIcon, Color iconColor) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
