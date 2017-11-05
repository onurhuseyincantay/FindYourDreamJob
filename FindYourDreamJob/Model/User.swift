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
    private var _userKey : String?
    private var _aboutDescription : String?
    var aboutDescription : String!{
        get{
            return _aboutDescription
        }
        set{
            _aboutDescription = newValue
        }
    }
    var userKey : String!{
        return _userKey
    }
    var companyNameorNickname : String! {
        get{
            return _companyNameorNickname
        }
        set{
            _companyNameorNickname = newValue
        }
    }
    var email : String!{
        get{
            return _email
        }
        set{
            _email = newValue
        }
    }
    var password : String!{
        return _password
    }
    var profileImageURL : String!{
        return _profileImageURL
    }
    init(companyNameorNickname : String  , email : String, password : String,profileimageURL:String = "https://firebasestorage.googleapis.com/v0/b/findyourdreamjob-410a4.appspot.com/o/ProfileImages%2Fperson.png?alt=media&token=148f5e6e-eb79-4e61-bf37-305c40422b83",userkey:String,about : String = "") {
    self._companyNameorNickname = companyNameorNickname
    self._aboutDescription = about
    self._email = email
        self._userKey = userkey
    self._password = password
    self._profileImageURL = profileimageURL // default olarak çekiceği yer belli tekrar tekrar placeholder image yüklemesin
    }
}
