//
//  RoundedImage.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 60
        self.contentMode = .scaleAspectFit
        self.layer.masksToBounds = true
    }

}
