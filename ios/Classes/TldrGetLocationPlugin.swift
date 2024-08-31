import Flutter
import UIKit
import CoreLocation

public class TldrGetLocationPlugin: NSObject, FlutterPlugin {
   private let locationHelper = LocationHelper()

   public static func register(with registrar: FlutterPluginRegistrar) {
       let channel = FlutterMethodChannel(name: "tldr_get_location", binaryMessenger: registrar.messenger())
       let instance = TldrGetLocationPlugin()
       registrar.addMethodCallDelegate(instance, channel: channel)
   }

   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getCurrentLocation" {
            locationHelper.getCurrentLocation { location, error in
                if let error = error {
                    result(FlutterError(code: "ERROR", message: "\(error.rawValue)", details: nil))
                } else if let location = location {
                    result([
                        "latitude": location.coordinate.latitude,
                        "longitude": location.coordinate.longitude
                    ])
                }
            }
        } else if call.method == "getPlatformVersion"  {
            result("iOS " + UIDevice.current.systemVersion)
        } else {
            result(FlutterMethodNotImplemented)
        }
   }
}
