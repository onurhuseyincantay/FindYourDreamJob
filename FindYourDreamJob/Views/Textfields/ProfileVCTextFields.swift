//
//  ProfileVCTextFields.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 26.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ProfileVCTextFields: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 20
        self.returnKeyType = .done
        self.layer.masksToBounds = true
        let placeholder = self.placeholder
        self.borderStyle = .none
        self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
       
        
    }

}
