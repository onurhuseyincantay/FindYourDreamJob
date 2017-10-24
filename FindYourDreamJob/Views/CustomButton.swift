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
        if self.tag == 0 {
            self.setImage(UIImage(named: "editIcon"), for: .normal)
            self.setTitle("Edit", for: .normal)
            
        }else if tag == 1 {
           self.setImage(UIImage(named: "editingCompleted"), for: .normal)
            self.imageView?.contentMode = .scaleAspectFit
            self.setTitle("Done", for: .normal)
        }
        self.tintColor = UIColor.black
        self.titleLabel?.font = UIFont(name : "Avenir Black Oblique", size: 20)
        self.titleLabel?.textColor = UIColor.black
        
     }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {

            return CGRect(x: contentRect.midX, y:contentRect.midY, width: 50, height: 50)
    }
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
            // button a ait imagelerin konumlandırmasında kaldın
        return CGRect(x: (imageView?.frame.maxX)! , y :(imageView?.frame.maxY)!, width:50.0, height:44.0)

    }
   
    
}



