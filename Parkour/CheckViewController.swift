//
//  CheckViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 30/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import SVProgressHUD
import MapKit
import CoreLocation

class CheckViewController: UIViewController {

//    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var ctr: UILabel!
    @IBOutlet weak var name : UILabel!
    
    var dat = JSON()
    var arr = [JSON()]
    override func viewDidLoad() {
        super.viewDidLoad()
        container.layer.cornerRadius = 10
        SVProgressHUD.show()
        let ref = Database.database().reference().child("User")
        ref.observe(.value) { (snap) in
            self.dat = JSON(snap.value)
            self.check()
            
        }
    }
    func check(){
        for (key,subJson):(String,JSON) in dat{
            if key != newUser.uid{
                if subJson["rentout"].stringValue != "0" && subJson["count2"].stringValue != "0"{
                    arr.append(subJson)
                    
                }
            }
        }
        print(arr[1])
        name.text = arr[1]["rentOut_InTime"].stringValue+" - "+arr[1]["rentOut_OutTime"].stringValue
        ctr.text = arr[1]["count2"].stringValue + " Spaces"
        city.text = arr[1]["city"].stringValue
        print(arr[1]["username"].string)
        SVProgressHUD.dismiss()
    }
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.setBackgroundColor(.purple)
        SVProgressHUD.setForegroundColor(.yellow)
    }
    func openMapForPlace() {

        let lat1 : NSString = NSString(string: arr[1]["lat"].stringValue)
        let lng1 : NSString = NSString(string: arr[1]["lon"].stringValue)

        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: options)

    }
    @IBAction func go(_ sender: Any) {
        openMapForPlace()
    }
}

