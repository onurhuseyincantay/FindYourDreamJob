//
//  JobDetailVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import Firebase
class JobDetailVC: UIViewController {
    
    @IBOutlet weak var applyButton: JobPostingButton!
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var employmentType: UILabel!
    @IBOutlet weak var jobtitle: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var workArea: UILabel!
    @IBOutlet weak var companyName: UILabel!
    var job = Job()
    override func viewDidLoad() {
        super.viewDidLoad()
        applyButtonSettings()
        self.setUI()
    }
    func setUI() {
        jobDescription.text = self.job.description
        companyImage.loadImages(urlString: job.companyImageURL)
        employmentType.text = self.job.employmentType
        jobtitle.text = self.job.title
        country.text = self.job.jobPlace
        caption.text = self.job.caption
        companyName.text = self.job.companyName
        workArea.text = self.job.workArea
    }
    
    func applyButtonSettings()  {
        if CURRENT_USER is CompanyUser{
            applyButton.isEnabled = false
            applyButton.isHidden = true
        }else{
            applyButton.isEnabled = true
            applyButton.isHidden = false
        }
    }
    
    @IBAction func ApplyPressed(_ sender: Any) {
        let values : [String:AnyObject] = [ (CURRENT_USER?.userKey)!:"1" as AnyObject]
        Database.ds.REF_APPLYMENTS.child(job.jobKey).updateChildValues(values)
        print("Onur : Applyment Posted")
        self.dismiss(animated: true, completion: nil)
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    @IBAction func backToJobs(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
