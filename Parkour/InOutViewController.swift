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

class InOutViewController: UIViewController {

    @IBOutlet weak var `in`: UIDatePicker!
    @IBOutlet weak var out: UIDatePicker!
    @IBOutlet weak var book: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        `in`.datePickerMode = .time
        out.datePickerMode = .time
        `in`.timeZone = TimeZone(secondsFromGMT: 5*60*60)
        out.addTarget(self, action: #selector(handler(sender:)), for: UIControl.Event.valueChanged)
        `in`.addTarget(self, action: #selector(handler(sendeer:)), for: UIControl.Event.valueChanged)
        out.setValue(UIColor.purple, forKey: "textColor")
        `in`.setValue(UIColor.purple, forKey: "textColor")
        book.layer.cornerRadius = 8
    }
    @objc func handler(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeFormatter.timeZone = TimeZone(secondsFromGMT: 5*60*60)
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

    
    @IBAction func book(_ sender: Any) {
        newUser.rentin = "1"
        var data = JSON()
        var dat = ["count":newUser.count]
        let ref = Database.database().reference().child("User").child(newUser.uid)
        print(newUser.name)
        data = JSON(newUser.count)
        ref.setValue(dat)
        
    }
}
