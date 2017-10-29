//
//  ApplymentsCell.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 29.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ApplymentsCell: UITableViewCell {
    

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var employmentTypeLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImage: RoundedImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setParameters(employmentType:String,jobTitle:String,userName:String,ImageURL:String,captionText:String) {
        self.employmentTypeLabel.text = employmentType
        self.jobTitleLabel.text = jobTitle
        self.userNameLabel.text = userName
        self.caption.text = captionText
        self.profileImage.loadImages(urlString: ImageURL)
    }
   

}
