//
//  CustomTextField.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = BLUE.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 20
        self.returnKeyType = .done
        self.layer.masksToBounds = true
        let placeholder = self.placeholder
        if self.tag != 2{
            self.borderStyle = .none
            self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
            self.backgroundColor = UIColor.clear
        }else{
            self.backgroundColor = UIColor.white
            self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        }
        
    }
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: 10, dy: 5)
//    }
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: 10, dy: 5)
//    }

}
