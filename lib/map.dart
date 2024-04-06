
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
      title: 'Library Finder',
      home: LibraryFinder(),
    );
  }
}

class LibraryFinder extends StatefulWidget {
  @override
  _LibraryFinderState createState() => _LibraryFinderState();
}

class _LibraryFinderState extends State<LibraryFinder> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(0, 0);
  Set<Marker> markers = {};

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
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
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
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_webservice/places.dart';

// class DinoMaps extends StatefulWidget {
//   @override
//   _DinoMapsState createState() => _DinoMapsState();
// }

// class _DinoMapsState extends State<DinoMaps> {
//   GoogleMapController? mapController;
//   final places =
//       GoogleMapsPlaces(apiKey: 'AIzaSyAFcQFzD4JKAcQYLZvFstKIplzhl64GafU'); // Replace with your API key
//   late LatLng _center;
//   Set<Marker> _markers = {};

//   @override
//   void initState() {
//     super.initState();
//     _center = const LatLng(13.794282, 100.324058); // Default center (Bangkok)
//     _getNearbyLibraries(_center);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map'),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 12.0,
//             ),
//             markers: _markers,
//           ),
//         ],
//       ),
//     );
//   }

//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       mapController = controller;
//     });
//   }

//   void _getNearbyLibraries(LatLng location) async {
//     final response = await places.searchNearbyWithRadius(
//         Location(lat: location.latitude, lng: location.longitude), 5000,
//         type: 'library');

//     if (response.isOkay) {
//       setState(() {
//         _markers = response.results
//             .map((result) => Marker(
//                   markerId: MarkerId(result.placeId),
//                   position: LatLng(
//                     result.geometry!.location.lat,
//                     result.geometry!.location.lng,
//                   ),
//                   infoWindow: InfoWindow(
//                     title: result.name,
//                     snippet: result.vicinity,
//                   ),
//                 ))
//             .toSet();
//       });
//     } else {
//       print('Error fetching nearby libraries');
//     }
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'DinoMaps',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: DinoMaps(),
//     );
//   }
// }