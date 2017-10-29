//
//  JobCell.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 29.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

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
        self.jobTitleLabel.text = job.title
        self.jobDescription.text = job.description
        self.captionLabel.text = job.caption
        self.employmentTypeLabel.text = job.employmentType
        self.profileImage.loadImages(urlString: (CURRENT_USER?.profileImageURL)!)
        if(CURRENT_USER is CompanyUser){
            if let user = CURRENT_USER as? CompanyUser{
                self.workAreaLabel.text = user.workArea
        }
    }


}
}
