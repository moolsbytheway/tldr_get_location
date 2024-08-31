import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {

    enum LocationError: Int {
        case locationPermissionDenied = 1
        case locationServiceDisabled = 2
        case cannotGetLocation = 3
    }

    private let locationManager = CLLocationManager()
    private var onLocationResult: ((CLLocation?, LocationError?) -> Void)?
    private var permissionCompletion: ((Bool) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // Method to request location permissions
    func requestLocationPermission(completion: @escaping (Bool) -> Void) {
        self.permissionCompletion = completion

        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .restricted, .denied:
                    completion(false)
                case .authorizedWhenInUse, .authorizedAlways:
                    completion(true)
                @unknown default:
                    completion(false)
                }
            } else {
                // Handle iOS versions before 14.0
                switch CLLocationManager.authorizationStatus() {
                case .notDetermined:
                    locationManager.requestWhenInUseAuthorization()
                case .restricted, .denied:
                    completion(false)
                case .authorizedWhenInUse, .authorizedAlways:
                    completion(true)
                @unknown default:
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }

    // CLLocationManagerDelegate method to handle authorization changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if #available(iOS 14.0, *) {
            let authorizationStatus = locationManager.authorizationStatus
            handleAuthorizationStatus(authorizationStatus)
        } else {
            let authorizationStatus = CLLocationManager.authorizationStatus()
            handleAuthorizationStatus(authorizationStatus)
        }
    }

    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            permissionCompletion?(true)
        case .restricted, .denied:
            permissionCompletion?(false)
        case .notDetermined:
            // Do nothing, wait for the next authorization status change
            break
        @unknown default:
            permissionCompletion?(false)
        }
    }

    // Method to get current location
    func getCurrentLocation(onLocationResult: @escaping (CLLocation?, LocationError?) -> Void) {
        self.onLocationResult = onLocationResult

        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .authorizedWhenInUse, .authorizedAlways:
                    locationManager.requestLocation()
                default:
                    onLocationResult(nil, .locationPermissionDenied)
                }
            } else {
                // Handle iOS versions before 14.0
                switch CLLocationManager.authorizationStatus() {
                case .authorizedWhenInUse, .authorizedAlways:
                    locationManager.requestLocation()
                default:
                    onLocationResult(nil, .locationPermissionDenied)
                }
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
