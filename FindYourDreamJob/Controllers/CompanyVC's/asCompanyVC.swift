//
//  asCompany.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class asCompanyVC: UIViewController,UITableViewDataSource,UITableViewDelegate ,UITabBarDelegate{

    @IBOutlet weak var tabBar: UITabBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tabBar.delegate = self
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
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 1:
            performSegue(withIdentifier: "postingJobs", sender: nil)
            tabBar.selectedItem = tabBar.items?[0]
        case 2:
            performSegue(withIdentifier: "companyProfile", sender: nil)
            tabBar.selectedItem = tabBar.items?[0]
        
        case 3: performSegue(withIdentifier: "Applyments", sender: nil)
        tabBar.selectedItem = tabBar.items?[0]
        default:break
            
        }
    }
    
    
    @IBAction func logoutButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
