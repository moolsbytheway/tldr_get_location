import 'tldr_get_location_platform_interface.dart';

class TldrGetLocation {
  Future<String?> getPlatformVersion() {
    return TldrGetLocationPlatform.instance.getPlatformVersion();
  }

  Future<Map<String, double>?> getCurrentLocation() {
    return TldrGetLocationPlatform.instance.getCurrentLocation();
  }
}
