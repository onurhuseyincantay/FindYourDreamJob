//
//  ViewController.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class LoginVC: UIViewController ,UITextFieldDelegate{
    @IBOutlet weak var companyRegistiration: UISwitch!
    
    @IBOutlet weak var workArea: CustomTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var companyNameText: CustomTextField!
    @IBOutlet weak var emailText: CustomTextField!
    @IBOutlet weak var passwordText: CustomTextField!
    @IBOutlet weak var loginRegisterBtn: RoundedButton!
    @IBOutlet weak var forgotPassBtn: UIButton!
    @IBOutlet weak var companyRegStackView: UIStackView!
    
       override func viewDidLoad() {
        super.viewDidLoad()
        emailText.delegate = self
        passwordText.delegate = self
        companyNameText.delegate = self
        
    }
    @IBAction func isCompanyRegistiration(_ sender: UISwitch) {
        if sender.isOn{
            workArea.isHidden = false
            workArea.isEnabled = true
            companyNameText.placeholder = "Company Name"
        }else{
            workArea.isHidden = true
            workArea.isEnabled = false
            companyNameText.placeholder = "Username"
        }
    }
    
    @IBAction func loginRegisterButton(_ sender: RoundedButton) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
                loginPressed()
        case 1:
            registerPressed()
        default: break
        }
        
    }
    var user =  User(companyNameorNickname: "a", email: "a", password: "a")
    var companyUser = CompanyUser(workArea: "a", companyNameorNickname: "a", email: "a", password: "a")
    
 //burası da öyle
    func loginPressed() {
    
            performSegue(withIdentifier: "asCompany", sender: nil)
            
        
           // performSegue(withIdentifier: "asUser", sender: nil)
        
   }
    func registerPressed() {
        
    }
   
    
    @IBAction func forgotPassword(_ sender: UIButton) {
        
        
    }
 

    @IBAction func signInWithLinkedIn(_ sender: RoundedButton) {
        
    }
    

}

