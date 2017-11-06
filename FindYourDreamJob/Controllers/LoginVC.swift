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
            loginPressed(completed: {
                self.performSegue()
                self.emailText.text = ""
                self.passwordText.text = ""
            })
        case 1:
            registerPressed {
                self.performSegue()
                self.emailText.text = ""
                self.passwordText.text = ""
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
        linkedInAuth {
            self.loginPressed(completed: {
                if !self.notAuthenticatetUser{
                    // ilk defa kayıt olurken giriş işlemi gerçekleşiyor 2 defa auth ettikten sonrasında login işlemi gerçekleşmiyor
                    self.performSegue()
                }
            }, isLinkedinLogin: true)
            if self.notAuthenticatetUser{
                self.registerPressed(isLinkedInRegisteration: true, complete: {
                    self.performSegue()
                    self.notAuthenticatetUser = true
                })
            }
            
        }
    }
    var LinkedInvalues:[String: String]!
    func linkedInAuth(complete : @escaping finishedLoadingData) {
        let permissions: [AnyObject] = [LISDK_BASIC_PROFILE_PERMISSION, LISDK_EMAILADDRESS_PERMISSION] as [AnyObject]
        LISDKSessionManager.createSession(withAuth: permissions, state: nil , showGoToAppStoreDialog: true, successBlock: { (success) in
            let url = "https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,email-address,picture-url)"
            if LISDKSessionManager.hasValidSession(){
                LISDKAPIHelper.sharedInstance().getRequest(url, success: { (response) in
                    print(self.stringToDictionary(text: (response?.data)!)!)
                    if let dict = self.stringToDictionary(text: (response?.data)!){
                        let uid = dict["id"] as? String
                        let name = dict["firstName"] as? String
                        let lastName = dict["lastName"] as? String
                        let email = dict["emailAddress"] as? String
                        let pictureUrl = dict["pictureUrl"] as? String
                        let userName = "\(name!) \(lastName!)"
                        let isCompany = "0"
                        self.LinkedInvalues = ["Username":userName,"id":uid!,"Email":email!,"PictureUrl":pictureUrl!,"Password":uid!,"isCompany":isCompany]
                        complete()
                        print(dict.description)
                    }
                }, error: { (error) in
                    print("Onur : \(error.debugDescription)")
                })
            }
        }) { (error) in
            print("Onur: \(error.debugDescription)")
        }
   
    }
    
    func stringToDictionary(text : String) -> [String : AnyObject]? {
        if let data  = text.data(using: .utf8){
            do{
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
            }catch{
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func registerPressed(isLinkedInRegisteration : Bool = false,complete:@escaping finishedLoadingData) {
        if isLinkedInRegisteration{
            if let email = self.LinkedInvalues["Email"],let password = self.LinkedInvalues["Password"]{
                Firebase.Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil{
                        print(error.debugDescription)
                        return
                    }
                    guard let uid = self.LinkedInvalues["id"] else{
                        return
                    }
                    self.registeringUserWithUniueqID(uid: uid, values: self.LinkedInvalues)
                    complete()
                })
            }else{
                print("form is not valid ")
                return
            }
        }else{
            if let email = emailText.text,let password = passwordText.text,let username = companyNameText.text{
                Firebase.Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil{
                        print(error.debugDescription)
                        return
                    }
                    guard let uid = user?.uid else{
                        return
                    }
                    var values = ["Username": username , "Email": email , "Password": password,"isCompany":"0","About":"","profileImageURL":"https://firebasestorage.googleapis.com/v0/b/findyourdreamjob-410a4.appspot.com/o/ProfileImages%2Fperson.png?alt=media&token=148f5e6e-eb79-4e61-bf37-305c40422b83"]
                    if self.companyRegistiration.isOn{
                        guard let workArea = self.workArea.text else {
                            return
                        }
                        values ["WorkArea"] = workArea
                        values ["isCompany"] = "1"
                    }
                    self.registeringUserWithUniueqID(uid: uid, values: values)
                    complete()
                })
            }else{
                print("form is not valid ")
                return
            }
        }
        
        
    }
    
    
    func registeringUserWithUniueqID(uid:String,values: [String:String])  {
            if values["isCompany"] == "1" {
                CURRENT_USER = CompanyUser(workArea: values["WorkArea"]!, companyNameorNickname: values["Username"]! , email: values["Email"]! , password: values["Password"]!, userkey: uid, about: values["About"]!, companyProfileimageURL: values["profileImageURL"]!)
            }else{
                CURRENT_USER = User(companyNameorNickname: values["Username"]!, email: values["Email"]! , password: values["Password"]!, userkey: uid,about:values["About"]!)
            }
        
            Database.ds.REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error.debugDescription)
                return
                }
                })
        
        
    }
    var notAuthenticatetUser : Bool = false
    func loginPressed(completed : @escaping finishedLoadingData,isLinkedinLogin : Bool = false) {
        if isLinkedinLogin{
            if let email = self.LinkedInvalues["Email"], let password = self.LinkedInvalues["Password"]{
                Firebase.Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        self.notAuthenticatetUser = true
                        print(error.debugDescription)
                        return
                    }
                    if let userID = user?.uid{
                        Database.ds.REF_USERS.child(userID).observe(.value, with: { (snapshot) in
                            if let dict = snapshot.value as? Dictionary <String,String> {
                                if dict["isCompany"] == "1"{
                                    CURRENT_USER = CompanyUser(workArea: dict["WorkArea"]! , companyNameorNickname: dict["Username"]!, email: dict["Email"]!, password: dict["Password"]!, userkey: userID,about:dict["About"]!, companyProfileimageURL: dict["profileImageURL"]!)
                                    completed()
                                }else{
                                    CURRENT_USER = User(companyNameorNickname: dict["Username"]!, email: dict["Email"]!, password: dict["Password"]!, profileimageURL: dict["profileImageURL"]!, userkey: userID,about:dict["About"]!)
                                    completed()
                                }
                            }
                            
                        }, withCancel: { (error) in
                            print("ONUR : It's Not a CompanyUser")
                        })
                    }
                    
                })
            }
        }else{
            if let email = emailText.text , let password = passwordText.text{
                
                Firebase.Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                    if let userID = user?.uid{
                        Database.ds.REF_USERS.child(userID).observe(.value, with: { (snapshot) in
                            let id = snapshot.key
                            if let dict = snapshot.value as? Dictionary <String,String> {
                                if dict["isCompany"] == "1"{
                                    CURRENT_USER = CompanyUser(workArea: dict["WorkArea"]! , companyNameorNickname: dict["Username"]!, email: dict["Email"]!, password: dict["Password"]!, userkey: id, about:dict["About"]!, companyProfileimageURL:  dict["profileImageURL"]!)
                                    completed()
                                }else{
                                    CURRENT_USER = User(companyNameorNickname: dict["Username"]!, email: dict["Email"]!, password: dict["Password"]!, profileimageURL:  dict["profileImageURL"]!, userkey: id, about: dict["About"]!)
                                    completed()
                                }
                            }
                            
                        }, withCancel: { (error) in
                            print("ONUR : It's Not a CompanyUser")
                        })
                    }
                    
                })
            }
        }
        
 }
    
}

