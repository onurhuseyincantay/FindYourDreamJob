//
//  Extensions.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import UIKit

extension LoginVC {
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loginRegisterBtn.setTitle("Login", for: .normal)
            companyNameText.isHidden = true
            companyNameText.isEnabled = false
            workArea.isHidden = true
            workArea.isEnabled = false
            companyRegStackView.isHidden = true
        case 1:
            loginRegisterBtn.setTitle("Register", for: .normal)
            companyNameText.isHidden = false
            companyNameText.isEnabled = true
            companyRegStackView.isHidden = false
            if companyRegistiration.isOn{
                self.workArea.isEnabled = true
                self.workArea.isHidden = false
            }
            default: break
        }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}

