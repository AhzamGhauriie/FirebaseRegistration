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
    
   let imagePicker = UIImagePickerController()
    
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(ViewController.openGallery(tapGesture:)))
        myImage.isUserInteractionEnabled = true
        myImage.addGestureRecognizer(tapGesture)
        
    }
    @objc func openGallery(tapGesture: UITapGestureRecognizer){
        openGallery()
    }
    
    @IBAction func btnSubmit(_ sender: UIButton) {
        if (txttext != nil) && (txtEmail != nil) && (txtMob != nil) && (txtRoll != nil){
        self.dataFIR()
        
        self.removeAll()
        
        ToastView.shared.short(self.view, txt_msg: "Account Created Successfully")
        }
        else {
             ToastView.shared.short(self.view, txt_msg: "Field cannot be empty!")
        }
        
    }
   
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
    }
}

//extension ViewController{
//    
//    func uploadImage (_ image:UIImage, completion: @escaping (_ url: URL?) -> ()){
//        let storageRef = Storage.storage().reference().child("myimage.png")
//        let imgData = myImage.image?.pngData()
//        let metaData = StorageMetadata()
//        metaData.contentType = "image/png"
//        storageRef.putData(imgData!, metadata: metaData){
//            (metaData, error) in
//            if error == nil{
//                print("succs")
//                storageRef.downloadURL(completion: {(url, error) in
//                completion(url)})
//        }
//        else{
//            print("abc")
//            completion(nil)
//            }
//        }
//    }
//    
//    func saveImage(name: String, profileURL:URL,completion:)
//}
