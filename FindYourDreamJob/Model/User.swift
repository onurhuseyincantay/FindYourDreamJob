//
//  User.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 23.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
class User {
    private var _companyNameorNickname : String!
    private var _workArea : String!
    private var _email : String!
    private var _password : String!
    let _isCompany : Bool!
    
    var companyNameorNickname : String {
        return _companyNameorNickname
    }
    var workArea : String{
        return _workArea
    }
    var email : String{
        return _email
    }
    var password : String!{
        return _password
    }
    var isCompany : Bool{
        return _isCompany
    }
    init(companyNameorNickname : String , workArea : String , email : String, password : String,isCompany : Bool) {
        self._companyNameorNickname = companyNameorNickname
        self._email = email
        self._password = password
        self._isCompany = isCompany
        if _isCompany{
            self._workArea = workArea
        }else{
            self._workArea = ""
        }
    }
}
