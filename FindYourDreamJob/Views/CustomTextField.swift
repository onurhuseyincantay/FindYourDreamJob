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
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
        self.returnKeyType = .done
        
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 5)
    }

}
