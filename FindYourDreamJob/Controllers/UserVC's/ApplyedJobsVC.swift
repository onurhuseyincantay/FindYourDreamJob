//
//  ApplyedJobs.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 29.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import Firebase
class ApplyedJobsVC: UIViewController,UITabBarDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var tabBar: UITabBar!
    var applyedJobKeys = [String]()
    var applyedJobDetails = [Job]()
    typealias finishGetingData = ()->()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tabBar.selectedItem = tabBar.items?[1]
        self.getApplyedJobs{
            self.getApplyedJobInfo {
                self.tableView.reloadData()
            }
        }
        
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0{
            dismiss(animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return applyedJobDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "applymentsCell", for: indexPath) as! ApplymentsCell
            cell.setParameters(job: applyedJobDetails[indexPath.row])
        return cell
    }
    func getApplyedJobs(completed:@escaping finishGetingData)  {
        Database.ds.REF_APPLYMENTS.observe(.value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshots{
                    if let userID = snap.value as? Dictionary<String,AnyObject>{
                        if let _ = userID[(CURRENT_USER?.userKey)!] as? String {
                            self.applyedJobKeys.append(snap.key)
                            print(snap.key)
                            
                        }
                        
                    }
                }
                completed()
        }
        }
        
    }
    func getApplyedJobInfo(completed:@escaping finishGetingData)  {
        Database.ds.REF_JOBS.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,AnyObject> {
                for job in self.applyedJobKeys{
                    let jobdetail = Job()
                    if let jobDict = dict[job] as? Dictionary<String,AnyObject>{
                        
                        jobdetail.caption = jobDict["Caption"] as? String
                        jobdetail.companyImageURL = jobDict["companyImageURL"] as? String
                        jobdetail.companyName = jobDict["companyName"] as? String
                        jobdetail.description = jobDict["description"] as? String
                        jobdetail.employmentType = jobDict["employmentType"] as? String
                        jobdetail.jobKey = jobDict["jobKey"] as? String
                        jobdetail.jobPlace = jobDict["jobPlace"] as? String
                        jobdetail.timeStamp = jobDict["timestamp"] as? NSNumber
                        jobdetail.title = jobDict["title"] as? String
                        jobdetail.workArea = jobDict["workArea"] as? String
                    }
                    self.applyedJobDetails.append(jobdetail)
                }
                completed()
                
            }
            
        }
        
        
    }
}
