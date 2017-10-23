//
//  CustomView.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class CustomView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
        layer.masksToBounds = true
        self.backgroundColor = BLUE.withAlphaComponent(0.85)
    }
   

}
