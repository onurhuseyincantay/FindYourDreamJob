//
//  ViewController.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import Firebase
class LoginVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var companyRegistiration: UISwitch!
    @IBOutlet weak var workArea: CustomTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var companyNameText: CustomTextField!
    @IBOutlet weak var emailText: CustomTextField!
    @IBOutlet weak var passwordText: CustomTextField!
    @IBOutlet weak var loginRegisterBtn: RoundedButton!
    @IBOutlet weak var companyRegStackView: UIStackView!
    typealias finishedLoadingData = () -> ()
       override func viewDidLoad() {
        
        super.viewDidLoad()
        emailText.delegate = self
        passwordText.delegate = self
        companyNameText.delegate = self
        companyRegistiration.isOn = true
    }
    @IBAction func isCompanyRegistiration(_ sender: UISwitch) {
        if sender.isOn{
            workArea.isHidden = false
            workArea.isEnabled = true
            companyNameText.attributedPlaceholder = NSAttributedString(string: "Company Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        }else{
            workArea.isHidden = true
            workArea.isEnabled = false
            companyNameText.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.darkGray])
        }
    }
    
    @IBAction func loginRegisterButton(_ sender: RoundedButton) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            loginPressed {
                    self.performSegue()
            }
            
        case 1:
            registerPressed()
            if companyRegistiration.isOn{
                performSegue(withIdentifier: "asCompany", sender: nil)
            }else{
                performSegue(withIdentifier: "asUser", sender: nil)
            }
        default: break
        }
        
    }
    func performSegue(){
        if (CURRENT_USER is CompanyUser){
            self.performSegue(withIdentifier: "asCompany", sender: nil)
        }else if (CURRENT_USER != nil){
            self.performSegue(withIdentifier: "asUser", sender: nil)
        }
    }
    @IBAction func signInWithLinkedIn(_ sender: RoundedButton) {
    
    }
    
    
    func registerPressed() {
        if let email = emailText.text,let password = passwordText.text,let username = companyNameText.text{
            Firebase.Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                guard let uid = user?.uid else{
                    return
                }
                
                var values = ["Username": username , "Email": email , "Password": password]
                if self.companyRegistiration.isOn{
                    guard let workArea = self.workArea.text else {
                        return
                    }
                    values ["WorkArea"] = workArea
                }
                self.registeringUserWithUniueqID(uid: uid, values: values)
                
            })
        }else{
            print("form is not valid ")
            return
        }
    }
    
    func registeringUserWithUniueqID(uid:String,values: [String:String])  {
        if self.companyRegistiration.isOn {
            Database.ds.REF_COMPANY_USERS.child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                 CURRENT_USER = CompanyUser(workArea: values["WorkArea"]!, companyNameorNickname: values["Username"]! , email: values["Email"]! , password: values["Password"]! )
            })
            
        }else{
            Database.ds.REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil{
                    print(error.debugDescription)
                    return
                }
                CURRENT_USER = User(companyNameorNickname: values["Username"]!, email: values["Email"]! , password: values["Password"]!)
                
            })
            }
    }
    
    func loginPressed(completed : @escaping finishedLoadingData) {
        if let email = emailText.text , let password = passwordText.text{
            Firebase.Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                
                if let userID = user?.uid{
                    Database.ds.REF_COMPANY_USERS.child(userID).observe(.value, with: { (snapshot) in
                        if let dict = snapshot.value as? Dictionary <String,String> {
                            CURRENT_USER = CompanyUser(workArea: dict["WorkArea"]! , companyNameorNickname: dict["Username"]!, email: dict["Email"]!, password: dict["Password"]!)
                        }
                        
                    }, withCancel: { (error) in
                        print("ONUR : It's Not a CompanyUser")
                    })
                    Database.ds.REF_USERS.child(userID).observe(.value, with: { (snapshot) in
                        if let dict = snapshot.value as? Dictionary <String,String> {
                            CURRENT_USER = User(companyNameorNickname: dict["Username"]!, email: dict["Email"]!, password: dict["Password"]!)
                        }
                        
                    }, withCancel: { (error) in
                        print("ONUR :It's Not a Normal User")
                    })
                }
                
               completed()
            })
          
            
    }
      
       
}
    
    
}
