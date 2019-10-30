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
    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login.layer.cornerRadius = 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setBackgroundColor(.purple)
        SVProgressHUD.setForegroundColor(.yellow)
    }
    var flag = 0
    func check(){
        let ref = Database.database().reference().child("User")
        ref.observeSingleEvent(of: .value) { (data) in
            let json = JSON(data.value)
            for (key,subJson):(String,JSON) in json{
                if subJson["username"].stringValue != self.usernamTF.text{
                    self.flag=1
                }else{
                    self.flag=0
                }
            }
            if self.flag==1{
                    print("aiyoo")
                self.validate()
            }
            else{
                let alertController = UIAlertController(title: "Sign Up", message: "Username already taken.", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    alertController.dismiss(animated: true, completion: nil)
                }
                self.flag=0
                SVProgressHUD.dismiss()
                alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
            }
            
        }
    }
    
    func validate(){
        let db = Database.database().reference().child("User").childByAutoId()
        let json:NSDictionary = ["username":usernamTF.text,"password":passwordTF.text,"name":nameTF.text]
        db.setValue(json)
        print("aiyoo1")
        newUser.user=usernamTF.text!
        newUser.name = nameTF.text!
        newUser.password = passwordTF.text!
        newUser.uid = db.key as! String
        SVProgressHUD.dismiss()
        performSegue(withIdentifier: "1", sender: nil)
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        SVProgressHUD.show()
        if usernamTF.text != "" && passwordTF.text != "" && nameTF.text != "" {
                check()
        }
    }
    
}
