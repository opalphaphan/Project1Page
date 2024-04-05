import 'package:flutter/material.dart';


void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            EditProfile(),
          ],
        ),
      ),
    );
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _bioController = TextEditingController();

    return Column(
      children: [
        Container(
          width: 394,
          height: 823,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFFCFCFC),
            boxShadow: [
              BoxShadow(
                color: const Color(0x3F000000),
                blurRadius: 60.57,
                offset: const Offset(0, 30.28),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 77,
                child: Container(
                  width: 393.68,
                  height: 656.14,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE6EEFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.47),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 68,
                top: 33,
                child: CircleAvatar(
                  radius: 128.5,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 115.65,
                    backgroundImage: NetworkImage("lib/assets/anton.jpg"),
                  ),
                ),
              ),
              Positioned(
                left: 55,
                top: 364,
                child: Container(
                  width: 284.55,
                  height: 81.55,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 262.35,
                        child: Text(
                          'Bio',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                      Container(
                        width: 284.55,
                        height: 52.30,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              width: 284.55,
                              height: 52.30,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.60,
                                    color: Color(0xFF282828),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: TextField(
                                controller: _bioController,
                                decoration: InputDecoration(
                                  hintText: 'Enter New Bio',
                                  hintStyle: TextStyle(
                                    color: Color(0xFFABABAB),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    height: 0,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  height: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 60,
                top: 513,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(
                            inputData: _bioController.text,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 274.54,
                      height: 45.62,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFA1BF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Center(
                        child: Text(
                          'Edit',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Profile extends StatelessWidget {
  final String inputData;

  const Profile({Key? key, required this.inputData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // your profile page code...
        Container(
          width: 394,
          height: 823,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Color(0xFFFCFCFC),
            boxShadow: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 60.57,
                offset: Offset(0, 30.28),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 77,
                child: Container(
                  width: 393.68,
                  height: 656.14,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE6EEFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.47),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 17,
                top: 359,
                child: Container(
                  width: 358,
                  height: 356,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 87,
                top: 360,
                child: SizedBox(
                  width: 229,
                  height: 71,
                  child: Text(
                    'Level 4\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 8,
                top: 390,
                child: SizedBox(
                  width: 214,
                  height: 59,
                  child: Text(
                    'Time Record : 100 min',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xCC424242),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: -7,
                top: 407,
                child: SizedBox(
                  width: 214,
                  height: 59,
                  child: Text(
                    'Book Record :   4',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF696969),
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 49,
                top: 503,
                child: SizedBox(
                  width: 303,
                  height: 193,
                  child: Text(
                    '$inputData',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xCC424242),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 89,
                top: 466,
                child: SizedBox(
                  width: 214,
                  height: 59,
                  child: Text(
                    'Bio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF424242),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.30,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 120,
                top: 50,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage(
                        "lib/assets/anton.jpg",
                      ),
                    ),
                    const SizedBox(height: 10.09),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10), // Add vertical padding of 3 units
                      child: Text(
                        'ANTONLEE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          height: 0.10,
                          letterSpacing: -0.41,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 7), // Add vertical padding of 3 units
                      child: Text(
                        'antonriize@gmail.com',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6C7A9C),
                          fontSize: 13.12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.13,
                          letterSpacing: -0.41,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3), // Add vertical padding of 3 units
                      child: Container(
                        width: 121.13,
                        height: 40.38,
                        padding: const EdgeInsets.all(10.09),
                        decoration: ShapeDecoration(
                          color: Color(0xFF5790DF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.19),
                          ),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    9), // Example: vertical padding of 10.0 units
                            child: Text(
                              'Edit',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                height: 0.13,
                                letterSpacing: -0.41,
                              ),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),



              Positioned(
                left: 49,
                top: 312,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 6.06,
                        height: 6.06,
                        decoration: ShapeDecoration(shape: OvalBorder()),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
