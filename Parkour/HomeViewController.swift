//
//  HomeViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 10/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController,UIAdaptivePresentationControllerDelegate{
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var rent: UIButton!
    @IBOutlet weak var rout: UIButton!
    
    @IBOutlet weak var hiLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiLabel.text = "Hi, " + name
        rent.layer.cornerRadius = 10
        rout.layer.cornerRadius = 10
    }
    
    @IBAction func locationButton(_ sender: Any) {
    }
}
