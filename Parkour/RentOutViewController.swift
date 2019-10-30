//
//  RentOutViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 30/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class RentOutViewController: UIViewController {
    @IBOutlet weak var nex: UIButton!
    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()
        nex.layer.cornerRadius = 6
        
    }
    
    @IBAction func slider(_ sender: Any) {
        sliderLabel.text = String(Int(slider.value))
        newUser.count1 = String(Int(slider.value))
        
    }
    
    

}
