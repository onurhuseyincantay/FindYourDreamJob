//
//  JobDetailVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class JobDetailVC: UIViewController {
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var employmentType: UILabel!
    @IBOutlet weak var jobtitle: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var companyName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
