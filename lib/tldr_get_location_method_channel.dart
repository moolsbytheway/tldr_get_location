import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tldr_get_location_platform_interface.dart';

/// An implementation of [TldrGetLocationPlatform] that uses method channels.
class MethodChannelTldrGetLocation extends TldrGetLocationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tldr_get_location');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
    await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<Map<String, double>?> getCurrentLocation() async {
    try {
      final Map<dynamic, dynamic>? result =
      await methodChannel.invokeMethod('getCurrentLocation');
      return result?.cast<String, double>();
    } catch (e) {
      print("error: " + e.toString());
      return null;
    }
  }
}
