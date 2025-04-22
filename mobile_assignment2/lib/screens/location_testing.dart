// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class DistanceScreen extends StatefulWidget {
//   @override
//   _DistanceScreenState createState() => _DistanceScreenState();
// }
//
// class _DistanceScreenState extends State<DistanceScreen> {
//   double? _distance;
//   String _status = "Press the button to calculate distance";
//
//   final double storeLat = 30.033333;
//   final double storeLng = 31.233334;
//
//   Future<void> _getDistance() async {
//     // Check location permission
//     var status = await Permission.location.request();
//     if (!status.isGranted) {
//       setState(() {
//         _status = "Location permission not granted.";
//       });
//       return;
//     }
//
//     // Get current position
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     // Calculate distance in meters
//     double distanceInMeters = Geolocator.distanceBetween(
//       position.latitude,
//       position.longitude,
//       storeLat,
//       storeLng,
//     );
//
//     setState(() {
//       _distance = distanceInMeters;
//       _status =
//           "Distance to favorite store is ${(_distance! / 1000).toStringAsFixed(2)} km";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Store Distance Checker")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(_status, textAlign: TextAlign.center),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _getDistance,
//               child: Text("Get Distance"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
