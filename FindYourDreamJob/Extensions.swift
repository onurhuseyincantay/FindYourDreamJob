//
//  Extensions.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import UIKit

extension LoginVC {
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            loginRegisterBtn.setTitle("Login", for: .normal)
            companyNameText.isHidden = true
            companyNameText.isEnabled = false
            workArea.isHidden = true
            workArea.isEnabled = false
            companyRegStackView.isHidden = true
        case 1:
            loginRegisterBtn.setTitle("Register", for: .normal)
            companyNameText.isHidden = false
            companyNameText.isEnabled = true
            companyRegStackView.isHidden = false
            if companyRegistiration.isOn{
                self.workArea.isEnabled = true
                self.workArea.isHidden = false
            }
            default: break
        }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}


extension UIImageView{
    func loadImages(urlString : String) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage{
            self.image = cachedImage // tekrar tekrar download etmesin cache den çeksin
            return
        }
        if let url = URL(string : urlString){
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                DispatchQueue.main.async {
                    if let downloadImage = UIImage(data: data!){
                        imageCache.setObject(downloadImage, forKey: urlString as NSString)
                        self.image = downloadImage
                    }
                }
            }).resume()
        }
    }
        
    
}

