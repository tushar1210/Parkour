//
//  OutViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 30/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
class OutViewController: UIViewController {

    @IBOutlet weak var inn: UIDatePicker!
    @IBOutlet weak var out: UIDatePicker!
    @IBOutlet weak var bookk: UIButton!
    
    override func viewDidLoad() {
       inn.datePickerMode = .time
            out.datePickerMode = .time
            inn.timeZone = TimeZone(secondsFromGMT: 5*60*60)
            out.addTarget(self, action: #selector(handle(sender:)), for: UIControl.Event.valueChanged)
            inn.addTarget(self, action: #selector(handler(sendeer:)), for: UIControl.Event.valueChanged)
            out.setValue(UIColor.purple, forKey: "textColor")
            inn.setValue(UIColor.purple, forKey: "textColor")
            bookk.layer.cornerRadius = 8
        }
        @objc func handle(sender: UIDatePicker) {
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = DateFormatter.Style.short
            timeFormatter.timeZone = TimeZone(secondsFromGMT: 5*66*60)
            let strDate = timeFormatter.string(from: out.date)
            newUser.rentOut_OutTime = strDate
        }
        
        @objc func handler(sendeer: UIDatePicker) {
            let timeFormatter = DateFormatter()
            timeFormatter.timeStyle = DateFormatter.Style.short
            timeFormatter.timeZone = TimeZone(secondsFromGMT: 5*60*60)
            let strDate = timeFormatter.string(from: inn.date)
            newUser.rentOut_InTime = strDate
           
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
        print("COST" , cost)
        newUser.mag2 = String(cost)
    }
    
    @IBAction func bookk(_ sender: Any) {
        newUser.rentout = "1"
        let ref = Database.database().reference().child("User").child(newUser.uid)
        var dat = ["count":newUser.count,"name":newUser.name,"password":newUser.password,"rentin":newUser.rentin,"rentout":newUser.rentout,"rentIn_InTime":newUser.rentIn_InTime,"rentIn_OutTime":newUser.rentIn_OutTime,"rentOut_OutTime":newUser.rentOut_OutTime,"rentOut_InTime":newUser.rentOut_InTime,"username":newUser.user,"mag1":newUser.mag1,"mag2":newUser.mag2,"city":newUser.city,"lat":newUser.outLat,"lon":newUser.outLon,"count2":newUser.count1]

        if newUser.rentOut_InTime != "" || newUser.rentOut_OutTime != ""{
            calculate(inn: newUser.rentOut_InTime, outt: newUser.rentOut_OutTime)
        }
        let alert = UIAlertController(title: "Confirm Lease ?", message: "Do you want to rent-out space from \(newUser.rentOut_InTime) to \(newUser.rentOut_OutTime)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            ref.setValue(dat)
            alert.dismiss(animated: true) {
               // self.openMapForPlace()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        alert.addAction(action)
        self.present(alert, animated: true)

    }
    
    }

