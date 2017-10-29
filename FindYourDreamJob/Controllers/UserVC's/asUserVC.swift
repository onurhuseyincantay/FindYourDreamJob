//
//  asUser.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class asUserVC: UIViewController,UITabBarDelegate,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
    }
    @IBAction func logoutButton(_ sender: UIButton) {
        CURRENT_USER = nil
        self.dismiss(animated: true, completion: nil)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 275
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "jobSelect", sender: nil)
  
        //senderda post bilgileri olacak
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

