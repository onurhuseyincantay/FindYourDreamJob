//
//  RoundedButton.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        if self.restorationIdentifier != "linkedInBtn"{
            layer.cornerRadius = 15
            clipsToBounds = true
            self.backgroundColor = BLUE
            self.titleLabel?.textColor = UIColor.white
        }else{
            self.imageView?.contentMode = .scaleAspectFill
        }
        
    }

}
