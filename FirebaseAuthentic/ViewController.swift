//
//  ViewController.swift
//  FirebaseAuthentic
//
//  Created by HigherVisibility on 24/12/2019.
//  Copyright © 2019 HigherVisibility. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController {
    
    @IBOutlet weak var txttext: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMob: UITextField!
    @IBOutlet weak var txtRoll: UITextField!
    
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        self.dataFIR()
        
        self.removeAll()
        
        ToastView.shared.short(self.view, txt_msg: "Account Created Successfully")
        
        
    }
    
    //    func toastT(){
    //        let toastLabel = UILabel()
    //
    //        toastLabel.lineBreakMode = .byWordWrapping
    //        toastLabel.numberOfLines = 0
    //        toastLabel.text = "Account Created Successfully"
    //        toastLabel.sizeToFit()
    //        //MARK Resize the Label Frame
    //        toastLabel.frame = CGRect(x: toastLabel.frame.origin.x, y: toastLabel.frame.origin.y, width: toastLabel.frame.size.width + 40, height: toastLabel.frame.size.height + 40)
    //
    //    }
    
    func removeAll(){
        txtRoll.text = ""
        txtMob.text = ""
        txtEmail.text = ""
        txttext.text = ""
        
    }
    
    func dataFIR(){
        
        let dict = ["Name":txttext.text!,"Email":txtEmail.text!,"Mobile Number":txtMob.text!,"Rollno":txtRoll.text!]
        
        self.ref.child("chat").childByAutoId().setValue(dict)
    }
    
}

