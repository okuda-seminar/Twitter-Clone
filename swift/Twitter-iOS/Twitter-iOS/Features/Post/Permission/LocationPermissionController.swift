import CoreLocation

class LocationPermissionController: NSObject {

  // MARK: - Private Props

  private let locationManager = CLLocationManager()

  // MARK: - Public API

  public func requestPermission(completion: @escaping (CLAuthorizationStatus) -> Void) {
    let status = locationManager.authorizationStatus

    if status == .notDetermined {
      // In the future, the line below should be executed after dismissing LocationAccessExplanationPopUpView.
      // For now, this is temporarily placed here to allow manual changes to the location setting and to check if
      // the location information is fetched correctly, as the location settings for the "Twitter-iOS" app do not appear
      // in the device's Settings menu until requestAlwaysAuthorization() or requestWhenInUseAuthorization() is called.
      locationManager.requestWhenInUseAuthorization()
    } else {
      completion(status)
    }
  }
}
