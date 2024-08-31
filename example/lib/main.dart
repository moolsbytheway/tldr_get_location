import 'package:flutter/material.dart';
import 'package:tldr_get_location/tldr_get_location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TldrGetLocation plugin example app'),
        ),
        body: const LocationWidget(),
      ),
    );
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  final _tldrGetLocationPlugin = TldrGetLocation();

  String _locationMessage = "Location not retrieved yet";

  void _getLocation() async {
    final location = await _tldrGetLocationPlugin.getCurrentLocation();
    if (location != null) {
      setState(() {
        _locationMessage =
            "Latitude: ${location['latitude']}, Longitude: ${location['longitude']}";
      });
    } else {
      setState(() {
        _locationMessage = "Failed to get location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(_locationMessage),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getLocation,
            child: const Text('Get Location'),
          ),
        ],
      ),
    );
  }
}
