import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DinoMaps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DinoMaps(),
    );
  }
}

class DinoMaps extends StatefulWidget {
  @override
  _DinoMapsState createState() => _DinoMapsState();
}

class _DinoMapsState extends State<DinoMaps> {
  late GoogleMapController mapController;
  late Position currentPosition;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      markers.add(Marker(
        markerId: MarkerId("current"),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });

    _getNearestLibrary(currentPosition.latitude, currentPosition.longitude);
  }

  void _getNearestLibrary(double latitude, double longitude) async {
    final apiKey = 'AIzaSyAFcQFzD4JKAcQYLZvFstKIplzhl64GafU'; // Replace with your actual Google Maps API key
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=500000000000000&type=library&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'];
      for (var result in results) {
        final name = result['name'];
        final geometry = result['geometry'];
        final location = geometry['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        final libraryPosition = LatLng(lat, lng);

        setState(() {
          markers.add(Marker(
            markerId: MarkerId(name),
            position: libraryPosition,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          ));
        });
      }
    } else {
      throw Exception('Failed to load libraries');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DinoMaps'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(0.0, 0.0),
              zoom: 15,
            ),
            markers: markers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(currentPosition.latitude, currentPosition.longitude),
                zoom: 15,
              ),
            ),
          );
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
