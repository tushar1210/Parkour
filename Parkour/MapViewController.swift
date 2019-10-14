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
        locView.layer.cornerRadius = 30
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            print("TIMER1")
            self.locationManager.stopUpdatingLocation()
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.long)
            self.locView.addAnnotation(annotation)
            self.locView.showsUserLocation = true
            
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
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        var region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.95, longitudeDelta: 0.95))
        locView.setRegion(region, animated: true)
    }
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
}
