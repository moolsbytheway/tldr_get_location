import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {

    enum LocationError: Int {
        case locationPermissionDenied = 1
        case locationServiceDisabled = 2
        case cannotGetLocation = 3
    }

    private let locationManager = CLLocationManager()
    private var onLocationResult: ((CLLocation?, LocationError?) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func getCurrentLocation(onLocationResult: @escaping (CLLocation?, LocationError?) -> Void) {
        self.onLocationResult = onLocationResult

        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                onLocationResult(nil, .locationPermissionDenied)
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
            @unknown default:
                onLocationResult(nil, .cannotGetLocation)
            }
        } else {
            onLocationResult(nil, .locationServiceDisabled)
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            onLocationResult?(location, nil)
        } else {
            onLocationResult?(nil, .cannotGetLocation)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        onLocationResult?(nil, .cannotGetLocation)
    }
}
