//
//  GradientView.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class GradientView: UIView {

   let gradientView = CAGradientLayer()
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = self.bounds
        gradientView.colors = [BLUE.cgColor,UIColor.white.cgColor]
        self.layer.insertSublayer(gradientView, at: 0)
    }

}
