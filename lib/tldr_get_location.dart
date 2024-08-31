import 'package:flutter/services.dart';
import 'package:tldr_get_location/model.dart';

import 'tldr_get_location_platform_interface.dart';

class TldrGetLocation {
  Future<String?> getPlatformVersion() {
    return TldrGetLocationPlatform.instance.getPlatformVersion();
  }

  Future<TldrLatLng?> getCurrentLocation() {
    return TldrGetLocationPlatform.instance.getCurrentLocation();
  }

  Future<bool> requestLocationPermission() {
    return TldrGetLocationPlatform.instance.requestLocationPermission();
  }
}