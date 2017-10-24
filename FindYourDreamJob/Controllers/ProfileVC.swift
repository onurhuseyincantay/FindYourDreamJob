//
//  ProfileVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,UITabBarDelegate{

    @IBOutlet weak var completeButton: CustomButton!
    @IBOutlet weak var stopEditing: UIButton!
    @IBOutlet weak var tabBar: UITabBar!
     override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[1]
        stopEditing.setTitle("Stop Editing", for: .normal)
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            dismiss(animated: true, completion: nil)
        }
    }
    

    @IBAction func stopEditingpressed(_ sender: Any) {
        stopEditing.isEnabled = false
        stopEditing.isHidden = true
    }
    @IBAction func editPressed(_ sender: Any) {
        stopEditing.isEnabled = true
        stopEditing.isHidden = false
        completeButton.isHidden = false
        completeButton.isEnabled = true
    }
    @IBAction func completePressed(_ sender: Any) {
    }
}
