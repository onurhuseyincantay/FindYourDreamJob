//
//  applymentsVC.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class applymentsVC: UIViewController,UITabBarDelegate {

    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.delegate = self
        tabBar.selectedItem = tabBar.items?[1]
    }
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0{
            dismiss(animated: true, completion: nil)
        }
    }

}
