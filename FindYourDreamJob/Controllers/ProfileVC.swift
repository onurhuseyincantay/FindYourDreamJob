//
//  ProfileVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,UITabBarDelegate{

    @IBOutlet weak var editButton: CustomButton!
    @IBOutlet weak var completeButton: CustomButton!

    @IBOutlet weak var tabBar: UITabBar!
     override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[1]
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func editPressed(_ sender: UIButton) {
      self.buttonUIhandling(sender)
    }
    @IBAction func completePressed(_ sender: UIButton) {
        self.buttonUIhandling(sender)
    }
    func buttonUIhandling(_ sender: UIButton)  {
        if sender.tag == 1{
            completeButton.isHidden = true
            completeButton.isEnabled = false
            sender.tag = 0
            sender.setTitle("Edit", for: .normal)
        }else
        {
            sender.setTitle("Stop Editing", for: .normal)
            sender.tag = 1
            completeButton.isHidden = false
            completeButton.isEnabled = true
        }
        if sender.titleLabel?.text == "Complete"{
            sender.isHidden = true
            sender.isEnabled = false
            self.editButton.tag = 0
            editButton.setTitle("Edit", for: .normal)
        }
    }
}
