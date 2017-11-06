//
//  applymentsVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit
import Firebase
class applymentsVC: UIViewController,UITabBarDelegate,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    var job = Job()
    var users = [User]()
    var user = User?.self
    var userAccepted = [String:String]()
    typealias finishUserDataDownload = ()->()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.getApplyedUserKey {
            self.tableView.reloadData()
        }
        tabBar.selectedItem = tabBar.items?[1]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "applymentsCell", for: indexPath) as! ApplymentsCell
        if let accepted:String = userAccepted[users[indexPath.row].userKey] {
            if accepted == "1"{
                cell.backgroundColor = UIColor(red: 104/255, green: 239/255, blue: 173/255, alpha: 0.5)
            }
        }
        cell.setParameters(job: job)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0{
            dismiss(animated: true, completion: nil)
        }
    }
    
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Reject = UITableViewRowAction(style: .default, title: "Reject") { (action, indexPath) in
            let user = self.users[indexPath.row]
            if let Id = user.userKey {
                Database.ds.REF_APPLYMENTS.child(self.job.jobKey).updateChildValues([Id:"-1"], withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                    self.users.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    
                })
            }

        }
        
        let confirm = UITableViewRowAction(style: .default, title: "Confirm") { (action, indexPath) in
            let user = self.users[indexPath.row]
            if let Id = user.userKey {
                Database.ds.REF_APPLYMENTS.child(self.job.jobKey).updateChildValues([Id:"1"])
                let cell = self.tableView.cellForRow(at: indexPath) as! ApplymentsCell
                cell.backgroundColor = UIColor(red: 104/255, green: 239/255, blue: 173/255, alpha: 0.5)
            }
            self.users.remove(at: indexPath.row)
        }
        confirm.backgroundColor = UIColor(red: 104/255, green: 239/255, blue: 173/255, alpha: 1)
        
        return [Reject, confirm]
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait
    }
    func getApplyedUserKey(completed : @escaping finishUserDataDownload)  {
        Database.ds.REF_APPLYMENTS.child(self.job.jobKey).observe(.value) { (snapshot) in
            let users = snapshot.children.allObjects as! [DataSnapshot]
                for user in users{
                     let value = user.value as! String
                        if value == "0" || value == "1"{
                            if value == "1"{
                                self.userAccepted[user.key] = value
                            }else{
                                self.userAccepted[user.key] = value
                            }
                            self.getApplyedUserData(key: user.key, completed: {
                                completed()
                        })
                }
                    
                }
        }
    }
   
   
    func getApplyedUserData(key : String,completed : @escaping finishUserDataDownload)  {
        Database.ds.REF_USERS.child(key).observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,AnyObject>{
                let about  = dict["About"] as? String
                let userKey = snapshot.key
                let email = dict["Email"] as? String
                let password = dict["Password"] as? String
                let Username = dict["Username"] as? String
                let profileImageURL = dict["profileImageURL"] as? String
                let user = User(companyNameorNickname: Username!, email: email!, password: password!, profileimageURL: profileImageURL!, userkey: userKey , about: about!)
                self.users.append(user)
                completed()
                
            }
        }
    }


}

