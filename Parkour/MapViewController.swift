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
        locView.layer.cornerRadius = 10
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        locView.delegate = self
           locView.mapType = .standard
           locView.isZoomEnabled = true
           locView.isScrollEnabled = true

           if let coor = locView.userLocation.location?.coordinate{
               locView.setCenter(coor, animated: true)
           }
    }
        
    override func viewDidAppear(_ animated: Bool) {
        locationManager.startUpdatingLocation()
        var timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: false) { (timer) in
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            lat = locValue.latitude
            long = locValue.longitude
        newUser.outLat = String(lat)
        newUser.outLon = String(long)
        print(lat,long)
        locView.mapType = MKMapType.standard
        let span = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
        let region = MKCoordinateRegion(center: locValue, span: span)
        locView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = newUser.name
        annotation.subtitle = "Current location"
        locView.addAnnotation(annotation)
        guard let location: CLLocation = manager.location else { return }
           fetchCityAndCountry(from: location) { city, country, error in
               guard let city = city, let country = country, error == nil else { return }
            self.locLabel.text = city
            newUser.city = city
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
