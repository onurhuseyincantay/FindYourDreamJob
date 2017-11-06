//
//  asUser.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import Firebase

class asUserVC: UIViewController,UITabBarDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var tableView: UITableView!
   
    var jobs = [Job]()
    var filteredjobs = [Job]()
    
    let cellId = "jobCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        Delegates()
        getJobDetails()
        self.attempReloadTable()
    }
    var inSearchMode : Bool = false
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            self.attempReloadTable()
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            let lower = searchBar.text!
            
            filteredjobs    = jobs.filter({$0.description.range(of: lower) != nil})
            self.attempReloadTable()
        }
    }
    func getJobDetails () {
        Database.ds.REF_JOBS.observe(.childAdded, with: { (snapshot) in
            self.fetchJobsAndAttemptReload(jobId: snapshot.key)
            print(snapshot)
        }) { (error) in
            print("Onur : \(error.localizedDescription)")
        }
    }
    private func fetchJobsAndAttemptReload(jobId : String){
        Database.ds.REF_JOBS.child(jobId).observeSingleEvent(of: .value, with: { (snapshot) in
            let job = Job()
            if let dict = snapshot.value as? Dictionary<String,AnyObject>{
                job.caption = dict["Caption"] as? String
                job.companyName = dict["companyName"] as? String
                job.description = dict["description"] as? String
                job.companyImageURL = dict["companyImageURL"] as? String
                job.employmentType = dict["employmentType"] as? String
                job.workArea = dict["workArea"] as? String
                job.jobPlace = dict["jobPlace"] as? String
                job.timeStamp = dict["timestamp"] as? NSNumber
                job.title = dict["title"] as? String
                job.jobKey = dict["jobKey"] as? String
                self.jobs.append(job)
            }
            self.attempReloadTable()
        }) { (error) in
            print("ONUR : \(error.localizedDescription)")
        }
    }
    private func attempReloadTable(){
        self.jobs.sort(by: { (job1, job2) -> Bool in
            return job1.timeStamp!.intValue > job2.timeStamp!.intValue
        })
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.HandleReloadDataDelay), userInfo: nil, repeats: false)
    }
    var timer : Timer?
    @objc func HandleReloadDataDelay()  {
        print("TableReloaded")
        self.tableView.reloadData()
    }
    func Delegates()  {
        tableView.delegate = self
        tabBar.delegate = self
        searchBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
        tableView.dataSource = self
    }
    @IBAction func logoutButton(_ sender: UIButton) {
        CURRENT_USER = nil
        self.dismiss(animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredjobs.count
        }
        return jobs.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! JobCell
        let job : Job!
        if inSearchMode {
            job = filteredjobs [indexPath.row]
            cell.setParameters(job: job)
        }else{
            job  = jobs[indexPath.row]
            cell.setParameters(job:job)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "userJobSelect", sender: jobs[indexPath.row])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userJobSelect"{
            if let nextScene = segue.destination as? JobDetailVC{
                nextScene.job = sender as! Job
            }
        }
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            performSegue(withIdentifier: "applyedJobs", sender: nil)
            tabBar.selectedItem = tabBar.items?[0]
        case 2:
            performSegue(withIdentifier: "userProfile", sender: nil)
            tabBar.selectedItem = tabBar.items?[0]
        default:break
    }
    }
    

}

