//
//  ViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 13/09/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Lottie
class ViewController: UIViewController {

    
let animView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animView.frame = CGRect(x: 67, y: 110, width: 240, height: 206)
        view.addSubview(animView)
        let anim = Animation.named("3532-car")
        animView.animation=anim
        animView.play()
        animView.loopMode = .loop
    }


    @IBAction func loginButton(_ sender: Any) {
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
}

