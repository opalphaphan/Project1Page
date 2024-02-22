
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Book Search App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: BookSearchPage(),
//     );
//   }
// }

// class BookSearchPage extends StatefulWidget {
//   @override
//   _BookSearchPageState createState() => _BookSearchPageState();
// }

// class _BookSearchPageState extends State<BookSearchPage> {
//   TextEditingController _controller = TextEditingController();
//   List<Book> _books = [];

//   Future<void> _searchBooks(String query) async {
//     final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

//     if (response.statusCode == 200) {
//       setState(() {
//         Iterable list = json.decode(response.body)['items'];
//         _books = list.map((model) => Book.fromJson(model)).toList();
//       });
//     } else {
//       throw Exception('Failed to load books');
//     }
//   }

//   void _showBookDetails(Book book) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => BookDetailsPage(book),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
        
//         title: TextField(
//           controller: _controller,
          
//           decoration: InputDecoration(
            
//             hintText: 'Search books...',
//             suffixIcon: IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 _searchBooks(_controller.text);
//               },
//             ),
//           ),
//         ),
//       ),
      
//       body: ListView.builder(
//         itemCount: _books.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: GestureDetector(
//               onTap: () {
//                 _showBookDetails(_books[index]);
//               },
//               child: Text(
//                 _books[index].title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             subtitle: Text(_books[index].author),
//           );
//         },
//       ),
//     );
//   }
// }

// class Book {
//   late String title;
//   late String author;
//   String? description;

//   Book({required this.title, required this.author, this.description});

//   factory Book.fromJson(Map<String, dynamic> json) {
//     var volumeInfo = json['volumeInfo'];
//     var authors = volumeInfo['authors'] as List<dynamic>?;
//     var description = volumeInfo['description'];

//     return Book(
//       title: volumeInfo['title'],
//       author: authors != null ? authors.join(", ") : "Unknown Author",
//       description: description,
//     );
//   }
// }

// class BookDetailsPage extends StatelessWidget {
//   final Book book;

//   BookDetailsPage(this.book);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(book.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Author(s): ${book.author}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Description:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 5),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Text(
//                   book.description ?? 'No description available',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


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

class _BookSearchPageState extends State<BookSearchPage> {
  TextEditingController _controller = TextEditingController();
  List<Book> _books = [];

  Future<void> _searchBooks(String query) async {
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=$query'));

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
            padding: const EdgeInsets.all(10.0), // Add padding around the TextField
            child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                filled: true, // Add this line to enable filling the TextField
                fillColor: Color.fromARGB(255, 139, 221, 250), // The fill color for the TextField
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
            image: AssetImage('lib/assets/search.png'), // Adjust the path as per your asset's location
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
    );
  }
}

class Book {
  late String title;
  late String author;
  String? description;

  Book({required this.title, required this.author, this.description});

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'];
    var authors = volumeInfo['authors'] as List<dynamic>?;
    var description = volumeInfo['description'];

    return Book(
      title: volumeInfo['title'],
      author: authors != null ? authors.join(", ") : "Unknown Author",
      description: description,
    );
  }
}

class BookDetailsPage extends StatelessWidget {
  final Book book;

  BookDetailsPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Author(s): ${book.author}',
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
                  book.description ?? 'No description available',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

