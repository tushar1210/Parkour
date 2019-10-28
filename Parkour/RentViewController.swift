//
//  RentViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 28/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit

class RentViewController: UIViewController {

    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    
    @IBAction func slider(_ sender: Any) {
        sliderLabel.text = String(Int(slider.value))
    }
    
}
