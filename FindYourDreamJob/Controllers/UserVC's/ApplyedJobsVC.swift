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
     var companyAccepted = [String:String]()
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
        return applyedJobKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "applymentsCell", for: indexPath) as! ApplymentsCell
        if let accepted:String = companyAccepted[applyedJobKeys[indexPath.row]] {
            if accepted == "1"{
                cell.backgroundColor = UIColor(red: 104/255, green: 239/255, blue: 173/255, alpha: 0.5)
            }
            
        }
            cell.setParameters(job: applyedJobDetails[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let jobKey = applyedJobDetails[indexPath.row].jobKey
        Database.ds.REF_APPLYMENTS.child(jobKey!).removeValue { (error, ref) in
            if error != nil {
                print(error.debugDescription)
                return
            }
            self.applyedJobKeys.remove(at: indexPath.row)
            self.tableView.reloadData()
        }      
        }
    
    func getApplyedJobs(completed:@escaping finishGetingData)  {
        Database.ds.REF_APPLYMENTS.observe(.value) { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot]{
                for snap in snapshots{
                    if let userID = snap.value as? Dictionary<String,AnyObject>{
                        if let value = userID[(CURRENT_USER?.userKey)!] as? String {
                            if value == "0" || value == "1"{
                                if value == "1"{
                                    self.companyAccepted[snap.key] = value
                                }else{
                                    self.companyAccepted[snap.key] = value
                                }
                            self.applyedJobKeys.append(snap.key)
                            print(snap.key)
                            
                        }
                        
                    }
                }
                completed()
        }
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
