//
//  JobPostingTF.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 28.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class JobPostingTF: ProfileVCTextFields {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.attributedPlaceholder = NSAttributedString(string: placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black])
        layer.borderColor = UIColor.black.cgColor
    }

}
