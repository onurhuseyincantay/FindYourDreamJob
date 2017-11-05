//
//  ProfileVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,UITabBarDelegate,UITextFieldDelegate{

    @IBOutlet weak var profileImage: RoundedImage!
    @IBOutlet weak var About: ProfileVCTextFields!
    @IBOutlet weak var Email: ProfileVCTextFields!
    @IBOutlet weak var userName: ProfileVCTextFields!
    @IBOutlet weak var editButton: CustomButton!
    @IBOutlet weak var completeButton: CustomButton!

    @IBOutlet weak var tabBar: UITabBar!
     override func viewDidLoad() {
        super.viewDidLoad()
        Email.isEnabled = false
        userName.isEnabled = false
        About.isEnabled = false
        self.Delegates()
        self.getProfileInfo()
        tabBar.selectedItem = tabBar.items?[1]
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
    }
    func updatingInformation(){
        if Email.text != CURRENT_USER?.email{
            let newEmail = Email.text
            Database.ds.FIR_AUTH.currentUser?.updateEmail(to: newEmail!, completion: { (error) in
                if error != nil {
                    print("Onur : \(error.debugDescription)")
                    return
                }
                let about = self.About.text
                let userName = self.userName.text
                if CURRENT_USER?.companyNameorNickname != userName{
                    Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["Username":userName!])
                }
                if CURRENT_USER?.aboutDescription != about {
                    Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["About":about!])
                }
            })
        }else{
            let about = self.About.text
            let userName = self.userName.text
            if CURRENT_USER?.companyNameorNickname != userName{
                Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["Username":userName!])
            }
            if CURRENT_USER?.aboutDescription != about {
                Database.ds.REF_USERS.child((CURRENT_USER?.userKey)!).updateChildValues(["About":about!])
            }
            
        }
       getProfileInfo()
    }
    func buttonUIhandling(_ sender: UIButton)  {
        if sender.tag == 1{
            completeButton.isHidden = true
            completeButton.isEnabled = false
            Email.isEnabled = false
            userName.isEnabled = false
            About.isEnabled = false
            Email.text = CURRENT_USER?.email
            userName.text = CURRENT_USER?.companyNameorNickname
            About.text = CURRENT_USER?.aboutDescription
            sender.tag = 0
            sender.setTitle("Edit", for: .normal)
        }else
        {
            sender.setTitle("Stop Editing", for: .normal)
            sender.tag = 1
            completeButton.isHidden = false
            completeButton.isEnabled = true
            Email.isEnabled = true
            userName.isEnabled = true
            About.isEnabled = true
        }
        if sender.titleLabel?.text == "Complete"{
            sender.isHidden = true
            sender.isEnabled = false
            Email.isEnabled = false
            userName.isEnabled = false
            About.isEnabled = false
            self.editButton.tag = 0
            editButton.setTitle("Edit", for: .normal)
        }
    }
}
