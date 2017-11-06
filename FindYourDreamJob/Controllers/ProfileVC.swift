//
//  ProfileVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import Photos
class ProfileVC: UIViewController,UITabBarDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var profileImage: RoundedImage!
    @IBOutlet weak var About: ProfileVCTextFields!
    @IBOutlet weak var Email: ProfileVCTextFields!
    @IBOutlet weak var userName: ProfileVCTextFields!
    @IBOutlet weak var editButton: CustomButton!
    @IBOutlet weak var completeButton: CustomButton!
    var tempImage = UIImage()
    var tempDownloadUrl : String?
    var profileImageIsEdited:Bool = false
    @IBOutlet weak var tabBar: UITabBar!
     override func viewDidLoad() {
        super.viewDidLoad()

        Email.isEnabled = false
        userName.isEnabled = false
        About.isEnabled = false
        self.Delegates()
        profileImage.isUserInteractionEnabled = false
        profileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(handleProfileImageViewSelection)))
        self.getProfileInfo()
        tabBar.selectedItem = tabBar.items?[1]
        
    }
    
   @objc  func handleProfileImageViewSelection(){
        PHPhotoLibrary.requestAuthorization { (status : PHAuthorizationStatus) in
            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                self.present(picker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker : UIImage?
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            selectedImageFromPicker = editedImage
            profileImageIsEdited = true
        }else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            selectedImageFromPicker = originalImage
            profileImageIsEdited = true
        }
        if let selectedImage = selectedImageFromPicker {
            tempImage = selectedImage
            self.profileImage.image
                = selectedImage
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Onur: Canceled")
        profileImageIsEdited = false
        self.dismiss(animated: true, completion: nil)
    }
    func uploadProfileImageData()  {
        if(profileImageIsEdited){
            let imageName = NSUUID().uuidString
            let storageRef = DB_STORAGEBASE.child("ProfileImages").child("\(imageName).jpg")
            if let uploadData = UIImageJPEGRepresentation(self.tempImage, 0.5){
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print("Onur : \(error.debugDescription)")
                        return
                    }
                    if let imageDownloadURL = metadata?.downloadURL()?.absoluteString{
                        Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["profileImageURL":imageDownloadURL])
                        self.tempDownloadUrl = imageDownloadURL
                        self.profileImage.image = self.tempImage
                    }
                })
            }
            
        }
    }
    func deleteCacheForImage(url : String)  {
        imageCache.removeObject(forKey: "url")
    }

    func getProfileInfo()  {
        Email.text = CURRENT_USER?.email
        userName.text = CURRENT_USER?.companyNameorNickname
        About.text = CURRENT_USER?.aboutDescription
        profileImage.loadImages(urlString: (CURRENT_USER?.profileImageURL)!)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func Delegates()  {
        About.delegate = self
        Email.delegate = self
        userName.delegate = self
        tabBar.delegate = self
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func editPressed(_ sender: UIButton) {
      self.buttonUIhandling(sender)
    }
    @IBAction func completePressed(_ sender: UIButton) {
        self.buttonUIhandling(sender)
        self.updatingInformation()
        if profileImageIsEdited{
        self.deleteCacheForImage(url: (CURRENT_USER?.profileImageURL)!)
         CURRENT_USER?.profileImageURL = tempDownloadUrl
        }
        self.uploadProfileImageData()
    }
    func updatingInformation(){
        if Email.text != CURRENT_USER?.email{
            let newEmail = Email.text
            Database.ds.FIR_AUTH.currentUser?.updateEmail(to: newEmail!, completion: { (error) in
                if error != nil {
                    print("Onur : \(error.debugDescription)")
                    return
                }
                self.Email.text = newEmail
                let about = self.About.text
                let userName = self.userName.text
                if CURRENT_USER?.companyNameorNickname != userName{
                    Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["Username":userName!])
                    self.userName.text = userName
                }
                if CURRENT_USER?.aboutDescription != about {
                    Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["About":about!])
                    self.About.text = about
                }
            })
        }else{
            let about = self.About.text
            let userName = self.userName.text
            if CURRENT_USER?.companyNameorNickname != userName && CURRENT_USER?.aboutDescription != about{
            Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["Username":userName!,"About":about!])
                self.userName.text = userName
                self.About.text = about
            }else if CURRENT_USER?.aboutDescription != about{
                Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["About":about!])
                self.About.text = about
            }else{
                Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["Username":userName!])
                self.userName.text = userName
            }
            
        }
       getProfileInfo()
    }
    
    
    func buttonUIhandling(_ sender: UIButton)  {
        if sender.titleLabel?.text == "Edit Profile"{
            completeButton.isHidden = false
            completeButton.isEnabled = true
            Email.isEnabled = true
            userName.isEnabled = true
            About.isEnabled = true
            profileImage.isUserInteractionEnabled = true
            Email.text = CURRENT_USER?.email
            userName.text = CURRENT_USER?.companyNameorNickname
            About.text = CURRENT_USER?.aboutDescription
            sender.tag = 0
            sender.setTitle("Stop Editing", for: .normal)
        }
        if sender.titleLabel?.text == "Stop Editing"{
            sender.setTitle("Edit Profile", for: .normal)
            completeButton.isHidden = true
            completeButton.isEnabled = false
            profileImage.isUserInteractionEnabled = false
            profileImage.loadImages(urlString: (CURRENT_USER?.profileImageURL)!)
            Email.isEnabled = false
            userName.isEnabled = false
            About.isEnabled = false
        }
        if sender.titleLabel?.text == "Complete"{
            sender.isHidden = true
            sender.isEnabled = false
            profileImage.isUserInteractionEnabled = false
            Email.isEnabled = false
            userName.isEnabled = false
            About.isEnabled = false
            editButton.setTitle("Edit Profile", for: .normal)
        }
    }
}
