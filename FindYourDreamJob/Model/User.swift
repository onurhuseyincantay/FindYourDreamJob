//
//  Protocols.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation

class User {
    private var _companyNameorNickname : String?
    private var _email : String?
    private var _password : String?
    private var _profileImageURL : String?
    var companyNameorNickname : String! {
        return _companyNameorNickname
    }
    var email : String!{
        return _email
    }
    var password : String!{
        return _password
    }
    var profileImageURL : String!{
        return _profileImageURL
    }
    init(companyNameorNickname : String  , email : String, password : String,profileimageURL:String = "https://firebasestorage.googleapis.com/v0/b/findyourdreamjob-410a4.appspot.com/o/ProfileImages%2Fperson.png?alt=media&token=148f5e6e-eb79-4e61-bf37-305c40422b83") {
    self._companyNameorNickname = companyNameorNickname
    self._email = email
    self._password = password
    self._profileImageURL = profileimageURL // default olarak çekiceği yer belli tekrar tekrar placeholder image yüklemesin
    }
}
