//
//  JobCell.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 29.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var profileImage: RoundedImage!
    @IBOutlet weak var employmentTypeLabel: UILabel!
    @IBOutlet weak var workAreaLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setParameters(job:Jobs) {
        if(CURRENT_USER is CompanyUser){
            if let companyUser = CURRENT_USER as? CompanyUser{
                self.workAreaLabel.text = companyUser.workArea
                self.companyNameLabel.isHidden = true
                if let url = companyUser.profileImageURL{
                    self.profileImage.loadImages(urlString:url)
                }
            }
            }
        self.companyNameLabel.text = job.companyName
        if let url = job.companyImageURL{
          self.profileImage.loadImages(urlString:url)
        }
        self.jobTitleLabel.text = job.title
        self.jobDescription.text = job.description
        self.captionLabel.text = job.caption
        self.employmentTypeLabel.text = job.employmentType
    }
}
