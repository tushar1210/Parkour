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
    
    var val = JSON()
    var autoId = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.setBackgroundColor(.purple)
        SVProgressHUD.setForegroundColor(.yellow)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func validated(){
        SVProgressHUD.show()
        let db = Database.database().reference().child("User")
        db.observe(.value) { (data) in
            self.val = JSON(data.value)
            SVProgressHUD.show()
            for (key,subJson):(String, JSON) in self.val {
                if subJson["username"].stringValue==self.userNameTF.text && subJson["password"].stringValue==self.passworTF.text{
                    self.autoId = key
                    print("success")
                    SVProgressHUD.dismiss()
                    name = subJson["name"].stringValue
                    user = subJson["username"].stringValue
                    self.performSegue(withIdentifier: "1", sender: nil)
                }
                else{
                    SVProgressHUD.dismiss()
                    let alertController = UIAlertController(title: "Login", message: "Incorrect Credentials", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action) in
                        alertController.dismiss(animated: true, completion: nil)
                    }
                    alertController.addAction(action)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        if userNameTF.text != "" && passworTF.text != "" {
            validated()
        }else{
            SVProgressHUD.dismiss()
        }
    }
    
}
