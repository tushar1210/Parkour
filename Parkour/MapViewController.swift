//
//  MapViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 10/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var locView: MKMapView!
    let locationManager = CLLocationManager()
    var lat = Double()
    var long = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        locView.delegate=self
        locationManager.delegate=self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        lat = locValue.latitude
        long = locValue.longitude
        guard let location: CLLocation = manager.location else { return }
           fetchCityAndCountry(from: location) { city, country, error in
               guard let city = city, let country = country, error == nil else { return }
            self.locLabel.text = city
        }
    }
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}
