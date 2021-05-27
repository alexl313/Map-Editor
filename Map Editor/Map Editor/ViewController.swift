

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapK: MKMapView!
    @IBOutlet weak var searchB: UISearchBar!
    
    var mpCord = CLLocationCoordinate2DMake(42.066418, -87.937294)
    let locationManager = CLLocationManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        mapK.mapType = .satelliteFlyover
        mapK.showsCompass = true
        mapK.showsBuildings = true
        mapK.showsTraffic = true
        mapK.showsUserLocation = true
        mapK.centerCoordinate = mpCord
        
        checkLocationServices()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
           mapK.setRegion(region, animated: true)
    }
      
       func checkLocationAuthorization() {
           switch CLLocationManager.authorizationStatus() {
           case .authorizedWhenInUse:
               mapK.showsUserLocation = true
               followUserLocation()
               locationManager.startUpdatingLocation()
               break
           case .denied:
               // Show alert
               break
           case .notDetermined:
               locationManager.requestWhenInUseAuthorization()
           case .restricted:
               // Show alert
               break
           case .authorizedAlways:
               break
            default: break
            //<#fatalError()#>
           }
       }
       
       func checkLocationServices() {
           if CLLocationManager.locationServicesEnabled() {
               setupLocationManager()
               checkLocationAuthorization()
           } else {
               // the user didn't turn it on
           }
       }
       
       func followUserLocation() {
           if let location = locationManager.location?.coordinate {
               let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
               mapK.setRegion(region, animated: true)
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           checkLocationAuthorization()
       }
       
       func setupLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
       }

    
    
    
    
    
    
    
    
    
}

