
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Finder',
      home: LibraryFinder(),
    );
  }
}

class LibraryFinder extends StatefulWidget {
  @override
  _LibraryFinderState createState() => _LibraryFinderState();
}

class _LibraryFinderState extends State<LibraryFinder> with TickerProviderStateMixin {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(0, 0);
  Set<Marker> markers = {};
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();

    _motionTabBarController = MotionTabBarController(
      initialIndex: 3,
      length: 5,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _findLibraries();
  }

  void _findLibraries() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude;
    final longitude = position.longitude;

    // Marker for the current location with a blue pin
    final currentLocationMarker = Marker(
      markerId: MarkerId('currentLocation'),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: 'My Location'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    final response = await http.post(
      Uri.parse('https://places.googleapis.com/v1/places:searchNearby'),
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': 'AIzaSyAFcQFzD4JKAcQYLZvFstKIplzhl64GafU', 
        'X-Goog-FieldMask': 'places.displayName,places.location',
      },
      body: jsonEncode({
        'locationRestriction': {
          'circle': {
            'center': {'latitude': latitude, 'longitude': longitude},
            'radius': 5000.0,
          },
        },
        'includedTypes': ['library'],
        'maxResultCount': 10,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final places = data['places'];

      setState(() {
        markers.clear();
        markers.add(currentLocationMarker); // Add current location marker
        for (var place in places) {
          final latLng = LatLng(
            place['location']['latitude'],
            place['location']['longitude'],
          );
          markers.add(
            Marker(
              markerId: MarkerId(place['displayName']['text']),
              position: latLng,
              infoWindow: InfoWindow(title: place['displayName']['text']),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          );
        }
      });

      if (places.isNotEmpty) {
        mapController.animateCamera(CameraUpdate.newLatLngBounds(_boundsFromLatLngList(markers.map((m) => m.position).toList()), 100));
      }
    } else {
      print('Failed to find libraries: ${response.body}');
    }
  }

  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    x0 = x1 = list.first.latitude;
    y0 = y1 = list.first.longitude;
    for (LatLng latLng in list) {
      if (latLng.latitude > x1) x1 = latLng.latitude;
      if (latLng.latitude < x0) x0 = latLng.latitude;
      if (latLng.longitude > y1) y1 = latLng.longitude;
      if (latLng.longitude < y0) y0 = latLng.longitude;
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  Future<void> _showLibraryInfo(String libraryName) async {
    // Replace this with your own logic to fetch detailed information about the library
    // For now, let's just show a simple alert dialog with the library name
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Library Information'),
          content: Text('Library Name: $libraryName'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
      preferredSize: Size.fromHeight(80.0), 
      child: AppBar(
         automaticallyImplyLeading: false,
        title: Image.asset(
          'lib/assets/Dinomap.png', 
          height: 78, 
        ),
        backgroundColor: Color.fromRGBO(87, 144, 223, 1.0),
      ),
    ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 2,
        ),
        markers: markers,
        onTap: (LatLng latLng) {
          for (final marker in markers) {
            if (latLng == marker.position) {
              _showLibraryInfo(marker.infoWindow.title!);
              break;
            }
          }
        },
      ),bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "DinoMap",
        labels: const [
          "DinoReads",
          "DinoSearch",
          "Profile",
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
          } else if (value == 2) {
            Navigator.pushNamed(context, '/dinocom');
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
