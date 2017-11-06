//
//  postingJobsVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit


class postingJobsVC: UIViewController,UITabBarDelegate,UITextFieldDelegate,UITextViewDelegate{
    @IBOutlet weak var profileImage: RoundedImage!
    
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var jobPlace: JobPostingTF!
    @IBOutlet weak var employmentType: JobPostingTF!
    @IBOutlet weak var jobTitle: JobPostingTF!
    @IBOutlet weak var caption: JobPostingTF!
    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        Delegates()
        self.profileImage.loadImages(urlString: (CURRENT_USER?.profileImageURL)!)
    }
    func Delegates() {
        tabBar.delegate = self
        jobDescription.delegate = self
        jobDescription.returnKeyType = .done
        jobPlace.delegate = self
        employmentType.delegate = self
        jobTitle.delegate = self
        caption.delegate = self
        tabBar.selectedItem = tabBar.items?[1]
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag==0{
            dismiss(animated: true, completion: nil)
        }
    }
    //-----------
    //Landscape modu kapattım
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    //-----------
    func getValues() -> Job! {
        let job = Job()
        if let user = CURRENT_USER as? CompanyUser{
            job.caption = caption.text
            job.title = jobTitle.text
            job.jobPlace = jobPlace.text
            job.companyImageURL = user.profileImageURL
            job.workArea = user.workArea
            job.companyName = user.companyNameorNickname
            job.description = jobDescription.text
            job.employmentType = employmentType.text
            job.timeStamp = Date().timeIntervalSince1970 as NSNumber
            job.companyKey = CURRENT_USER?.userKey
        }
       return job
    }

    @IBAction func postPressed(_ sender: Any) {
        let job = getValues()
        let ref = Database.ds.REF_JOBS.childByAutoId()
        let values : [String:AnyObject] = ["Caption":job?.caption as AnyObject,"companyName":job?.companyName as AnyObject,"description":job?.description as AnyObject,"companyImageURL":job?.companyImageURL as AnyObject,"employmentType":job?.employmentType as AnyObject,"jobPlace":job?.jobPlace as AnyObject,"timestamp":job?.timeStamp as AnyObject,"title":job?.title as AnyObject,"workArea" : job?.workArea as AnyObject,"jobKey":ref.key as AnyObject,"companyKey":job!.companyKey as AnyObject]
        ref.updateChildValues(values)
    }
    
}
