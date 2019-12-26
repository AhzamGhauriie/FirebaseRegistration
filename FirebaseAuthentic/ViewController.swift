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
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var imgCam: UIButton!
    @IBOutlet weak var upLoad: UILabel!
    
    
    let imagePicker = UIImagePickerController()
    
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        

           //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        }

        //Calls this function when the tap is recognized.
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
            
        self.ref = Database.database().reference()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(ViewController.openGallery(tapGesture:)))
        myImage.isUserInteractionEnabled = true
        myImage.addGestureRecognizer(tapGesture)
        myImage.layer.masksToBounds = true
        myImage.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        myImage.layer.borderWidth = 0
        
    
    }
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        openGallery()
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if (txttext != nil) && (txtEmail != nil) && (txtMob != nil) && (txtRoll != nil){
            self.dataFIR()
            self.saveFireData()
            ToastView.shared.short(self.view, txt_msg: "Account Created Successfully")
            removeAll()
        
        }
      
    }
    
    func saveFireData(){
        self.uploadImage(self.myImage.image!){ url in
            self.saveImage(name: self.txttext.text!, profileURL: url!){success in
                if success != nil{
                    self.upLoad.text = ""
                    self.imgCam = nil
                    print("yo")
                }
            }
        }
    }
    func removeAll(){
        txtRoll.text = ""
        txtMob.text = ""
        txtEmail.text = ""
        txttext.text = ""
        myImage.image = nil
        
    }
    
    func dataFIR(){
        
        let dict = ["Name":txttext.text!,"Email":txtEmail.text!,"Mobile Number":txtMob.text!,"Rollno":txtRoll.text!]
        
        self.ref.child("chat").childByAutoId().setValue(dict)
    }
    
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.isEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        myImage.image = image
        self.dismiss(animated: true, completion: nil)
        self.upLoad.text = ""
        self.imgCam.alpha = 0    }
}

extension ViewController{
    
    func uploadImage (_ image:UIImage, completion: @escaping (_ url: URL?) -> ()){
        let storageRef = Storage.storage().reference().child("myimage.png")
        let imgData = myImage.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData){
            (metaData, error) in
            if error == nil{
                print("succs")
                storageRef.downloadURL(completion: {(url, error) in
                    completion(url)})
            }
            else{
                print("error")
                completion(nil)
            }
        }
    }
    
    func saveImage(name: String, profileURL:URL,completion: @escaping ((_ url:URL?) -> ())){
        
        let dict = ["Name":txttext.text!,"Email":txtEmail.text!,"Mobile Number":txtMob.text!,"Rollno":txtRoll.text!,"profileURL":profileURL.absoluteString] as [String:Any]
        
        self.ref.child("chat").childByAutoId().setValue(dict)
    }
}
