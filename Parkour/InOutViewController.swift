//
//  InOutViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 28/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

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
        
    }
}
