# TLDR get location

A simple flutter plugin to get current user location with minimum boilerplate.

# Screenshots
<img src="https://raw.githubusercontent.com/moolsbytheway/tldr_get_location/main/screenshots/latlng.png" alt="Coordinates" title="Coordinates" width="300">

## Getting Started

Update `MainActivity.kt` to extends `FlutterFragmentActivity` vs `FlutterActivity`.
Otherwise you'll get an error.

```kotlin
//import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
}
```

## IOS Configuration

Add the following to your `info.plist` file

```xml
    <dict>
        ...
        <key>NSLocationWhenInUseUsageDescription</key>
        <string>Do you allow this app to know your current location?</string>
        <true/>
        ...
    </dict>
```

## Android Configuration

Add the following permissions to the app level Android Manifest
```xml
<manifest>
    ...
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    ...
</manifest>
```

### How to use ?

Usage is simple as calling the method `getCurrentLocation`.
the method return a map with latitude and longitude as keys.

- Initialize the plugin

```dart
  final locationPlugin = TldrGetLocation();
```

- Get current location
The plugin will ask for required permission automatically

```dart
  TldrLatLng? location = await locationPlugin.getCurrentLocation();
  // check if null before using
  double? latitude = location?.latitude;
  double? longitude = location?.longitude;
```

## Example
```dart
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
    final TldrLatLng? location = await _tldrGetLocationPlugin.getCurrentLocation();
    if (location != null) {
      setState(() {
        _locationMessage =
        "Latitude: ${location.latitude}, Longitude: ${location.longitude}";
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
```
