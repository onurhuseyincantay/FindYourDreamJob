//
//  JobPostingButton.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 28.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import UIKit
class JobPostingButton: CustomButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.titleLabel?.textColor = UIColor.darkGray
    }
}
