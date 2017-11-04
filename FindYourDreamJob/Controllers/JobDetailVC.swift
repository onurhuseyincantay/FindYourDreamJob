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
    @IBOutlet weak var companyName: UILabel!
    var job = Job(){
        didSet{
            jobDescription.text = job.description
            companyImage.loadImages(urlString: job.companyImageURL)
            employmentType.text = job.employmentType
            jobtitle.text = job.title
            country.text = job.jobPlace
            caption.text = job.caption
            companyName.text = job.companyName
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        applyButtonSettings()
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
