//
//  SignUpViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 10/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import SVProgressHUD
import Firebase
import SwiftyJSON

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernamTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setBackgroundColor(.purple)
        SVProgressHUD.setForegroundColor(.yellow)
    }
    
    func check(){
        let ref = Database.database().reference().child("User")
        ref.observe(.value) { (data) in
            let json = JSON(data.value)
            print("\n\n\n",json)
            
            for (key,subJson):(String,JSON) in json{
                print("\nsub json\n",subJson)
                if subJson["username"].stringValue != self.usernamTF.text{
                    print("IF")
                    self.validate()
                }else{
                    print("ELSE")
                    
                    let alertController = UIAlertController(title: "Sign Up", message: "Username already taken.", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                    }
                    SVProgressHUD.dismiss()
                    alertController.addAction(action)
                        self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
        }
    }
    
    func validate(){
        
        
        let db = Database.database().reference().child("User").childByAutoId()
        let json:NSDictionary = ["username":usernamTF.text,"password":passwordTF.text,"name":nameTF.text]
        db.setValue(json)
        SVProgressHUD.dismiss()
        user=usernamTF.text!
        name = nameTF.text!
        performSegue(withIdentifier: "1", sender: nil)
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        SVProgressHUD.show()
        if usernamTF.text != "" && passwordTF.text != "" && nameTF.text != "" {
                check()
        }
    }
    
}
