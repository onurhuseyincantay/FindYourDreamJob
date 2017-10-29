//
//  ApplymentsCell.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 29.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ApplymentsCell: UITableViewCell {
    
    var job : Jobs?{
        didSet{
           employmentTypeLabel.text = job?.employmentType
            jobTitleLabel.text = job?.title
            userNameLabel.text = job?.users.companyNameorNickname
            if let url = job?.users.profileImageURL{
            profileImage.loadImages(urlString:url)
            }
        }
    }
    @IBOutlet weak var employmentTypeLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImage: RoundedImage!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   

}
