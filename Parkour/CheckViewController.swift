//
//  CheckViewController.swift
//  Parkour
//
//  Created by Tushar Singh on 30/10/19.
//  Copyright © 2019 Tushar Singh. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import SVProgressHUD

class CheckViewController: UIViewController {

//    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var go: UIButton!
    @IBOutlet weak var ctr: UILabel!
    @IBOutlet weak var name : UILabel!
    
    var dat = JSON()
    var arr = [JSON()]
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        let ref = Database.database().reference().child(newUser.uid)
        ref.observeSingleEvent(of: .value) { (snap) in
            self.dat = JSON(snap.value)
            self.check()
        }
    }
    func check(){
        for (key,subJson):(String,JSON) in dat{
            if key != newUser.uid{
                if subJson["rentout"] != "0" && subJson["count2"] != "0"{
                    arr.append(subJson)
                    
                }
            }
        }
        name.text = arr[0]["rentOut_InTime"].stringValue+arr[0]["rentOut_OutTime"].stringValue
        ctr.text = arr[0]["count2"].stringValue
        city.text = arr[0]["city"].stringValue
        SVProgressHUD.dismiss()
    }
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.setBackgroundColor(.purple)
        SVProgressHUD.setForegroundColor(.yellow)
    }
    @IBAction func go(_ sender: Any) {
        
    }
}

//extension CheckViewController{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return arr.count
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UIView()
//        footer.backgroundColor = .clear
//        footer.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: 20)
//        return footer
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
//}
