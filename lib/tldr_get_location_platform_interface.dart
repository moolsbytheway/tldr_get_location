import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:tldr_get_location/model.dart';

import 'tldr_get_location_method_channel.dart';

abstract class TldrGetLocationPlatform extends PlatformInterface {
  /// Constructs a TldrGetLocationPlatform.
  TldrGetLocationPlatform() : super(token: _token);

  static final Object _token = Object();

  static TldrGetLocationPlatform _instance = MethodChannelTldrGetLocation();

  /// The default instance of [TldrGetLocationPlatform] to use.
  ///
  /// Defaults to [MethodChannelTldrGetLocation].
  static TldrGetLocationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TldrGetLocationPlatform] when
  /// they register themselves.
  static set instance(TldrGetLocationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<TldrLatLng?> getCurrentLocation() {
    throw UnimplementedError('getCurrentLocation() has not been implemented.');
  }

  Future<bool> requestLocationPermission() {
    throw UnimplementedError('requestLocationPermission() has not been implemented.');
  }
}
