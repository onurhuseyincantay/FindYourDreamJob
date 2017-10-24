//
//  Protocols.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation

class User {
    private var _companyNameorNickname : String!
    private var _email : String!
    private var _password : String!
    
    var companyNameorNickname : String {
        return _companyNameorNickname
    }
    var email : String{
        return _email
    }
    var password : String!{
        return _password
    }
    init(companyNameorNickname : String  , email : String, password : String) {
    self._companyNameorNickname = companyNameorNickname
    self._email = email
    self._password = password
    }
}
