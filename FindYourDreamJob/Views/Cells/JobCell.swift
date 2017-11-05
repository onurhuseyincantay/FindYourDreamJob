//
//  JobCell.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 29.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var profileImage: RoundedImage!
    @IBOutlet weak var workAreaLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setParameters(job:Job) {
        if(CURRENT_USER is CompanyUser){
            if let companyUser = CURRENT_USER as? CompanyUser{
                self.companyNameLabel.isHidden = true
                self.companyNameLabel.isEnabled = false
                if let url = companyUser.profileImageURL{
                    self.profileImage.loadImages(urlString:url)
                }
            }
        }
        self.companyNameLabel.text = job.companyName
        if let url = job.companyImageURL{
          self.profileImage.loadImages(urlString:url)
        }
        self.workAreaLabel.text = job.workArea
        self.timeStamp.text = self.dateFormatter( job.timeStamp)
        self.jobTitleLabel.text = job.title
        self.jobDescription.text = job.description
        self.captionLabel.text = job.caption
        print(job.description)
    }
    func dateFormatter(_ dateTime : NSNumber) -> String {
       let dateFormatter = DateFormatter()
        let seconds = dateTime.doubleValue
            dateFormatter.dateFormat = "MMMM dd yyyy hh:mm:ss a"
             let date = Date(timeIntervalSince1970: seconds)
            let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

