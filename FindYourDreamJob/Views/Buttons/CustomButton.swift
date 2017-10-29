//
//  CustomButton.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1.5
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = UIColor.clear
        self.titleLabel?.textColor = UIColor.white
        
     }
   
    
}


