//
//  InOutViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 28/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import SwiftyJSON
import SVProgressHUD
import Firebase
import MapKit
import CoreLocation

class InOutViewController: UIViewController {

    @IBOutlet weak var `in`: UIDatePicker!
    @IBOutlet weak var out: UIDatePicker!
    @IBOutlet weak var book: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        `in`.datePickerMode = .time
        out.datePickerMode = .time
        `in`.timeZone = TimeZone(secondsFromGMT: 5*60*60)
        out.addTarget(self, action: #selector(handle(sender:)), for: UIControl.Event.valueChanged)
        `in`.addTarget(self, action: #selector(handler(sendeer:)), for: UIControl.Event.valueChanged)
        out.setValue(UIColor.purple, forKey: "textColor")
        `in`.setValue(UIColor.purple, forKey: "textColor")
        book.layer.cornerRadius = 8
    }
    @objc func handle(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 5*66*60)
        let strDate = timeFormatter.string(from: out.date)
        newUser.rentIn_OutTime = strDate
    }
    
    @objc func handler(sendeer: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 5*60*60)
        let strDate = timeFormatter.string(from: `in`.date)
        newUser.rentIn_InTime = strDate
       
    }
    
    func openMapForPlace() {

        let lat1 : NSString = NSString(string: newUser.outLat)
        let lng1 : NSString = NSString(string: newUser.outLon)

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
    
    func calculate(inn:String,outt:String){
        var x1 = 0
        var x2 = 0
        var mag = 0
        if inn.count==8{
            x1 = Int(inn[0..<2])!
        }
        if outt.count==8{
            x2 = Int(outt[0..<2])!
        }
        if inn.count==7{
            x1 = Int(inn[0..<1])!
        }
        if outt.count==7{
            x2 = Int(outt[0..<1])!
        }
        
        mag = x2-x1
        if mag<0{
            mag = 0-mag + 12
        }
        let cost = mag*50
//        print("COST" , cost)
        newUser.mag1 = String(cost)
    }
    
    @IBAction func book(_ sender: Any) {
        newUser.rentin = "1"
        let ref = Database.database().reference().child("User").child(newUser.uid)
        var dat = ["count":newUser.count,"name":newUser.name,"password":newUser.password,"rentin":newUser.rentin,"rentout":newUser.rentout,"rentIn_InTime":newUser.rentIn_InTime,"rentIn_OutTime":newUser.rentIn_OutTime,"rentOut_OutTime":newUser.rentOut_OutTime,"rentOut_InTime":newUser.rentOut_InTime,"username":newUser.user,"mag1":newUser.mag1,"mag2":newUser.mag2,"city":newUser.city,"lat":newUser.outLat,"lon":newUser.outLon,"count2":newUser.count1]
        
        if newUser.rentIn_InTime != "" || newUser.rentIn_OutTime != ""{
            calculate(inn: newUser.rentIn_InTime, outt: newUser.rentIn_OutTime)
        }
        let alert = UIAlertController(title: "Confirm Booking", message: "Do you want to confirm booking from \(newUser.rentIn_InTime) to \(newUser.rentIn_OutTime)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            ref.setValue(dat)
            alert.dismiss(animated: true) {
               // self.openMapForPlace()
                let al = UIAlertController(title: "Success", message: "Your booking has been successfully made.", preferredStyle: .alert)
                let act = UIAlertAction(title: "OK", style: .default) { (action) in
                    self.performSegue(withIdentifier: "1", sender: nil)
                }
                al.addAction(act)
                self.present(al,animated: true)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(action)
        self.present(alert, animated: true)
                
    }
}
extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}


