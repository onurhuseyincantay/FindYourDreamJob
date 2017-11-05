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
    func setParameters(job:Job) {
        
        self.userNameLabel.text = job.companyName
        if let url = job.companyImageURL{
            self.profileImage.loadImages(urlString:url)
        }
        self.jobTitleLabel.text = job.title
        self.employmentTypeLabel.text = job.employmentType
        self.caption.text = job.caption
        print(job.description)
    }
   

}
