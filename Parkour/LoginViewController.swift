//
//  LoginViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 10/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import SVProgressHUD

class LoginViewController: UIViewController,UIAdaptivePresentationControllerDelegate {

    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passworTF: UITextField!
    @IBOutlet weak var login: UIButton!
    
    var val = JSON()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        let db = Database.database().reference().child("User")
        db.observe(.value) { (data) in
            self.val = JSON(data.value)
//            print(self.val)
            SVProgressHUD.dismiss()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.setBackgroundColor(.purple)
        SVProgressHUD.setForegroundColor(.yellow)
        login.layer.cornerRadius = 5
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    var c = 0
    func validated(){
        SVProgressHUD.show()
            for (key,subJson):(String, JSON) in val {
//                print(subJson)
                if subJson["username"].stringValue==self.userNameTF.text && subJson["password"].stringValue==self.passworTF.text{
//                    print("success",subJson)
                    newUser.name = subJson["name"].stringValue
                    newUser.user = subJson["username"].stringValue
                    newUser.uid = key
                    c+=1
                    newUser.password = subJson["password"].stringValue
                    
                }
                
        }
                
                if c==0{
//                    print("sff")
                        SVProgressHUD.dismiss()
                        let alertController = UIAlertController(title: "Login", message: "Incorrect Credentials", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default) { (action) in
                            alertController.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(action)
                        self.present(alertController, animated: true, completion: nil)
                    
                }else{
                    performSegue(withIdentifier: "1", sender: nil)
                }
            
            SVProgressHUD.dismiss()
        }

    
    
    @IBAction func loginButton(_ sender: Any) {
        if userNameTF.text != "" && passworTF.text != "" {
            validated()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
}
