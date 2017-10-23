//
//  ProfileVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,UITabBarDelegate{

    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[0]
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        dismiss(animated: true, completion: nil)
    }
    
  
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
