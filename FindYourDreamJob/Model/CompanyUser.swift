//
//  CompanyUser.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation

class CompanyUser: User {
    private var _workArea : String!
    var workArea : String{
        return _workArea
    }

    init(workArea:String,companyNameorNickname: String, email: String, password: String,userkey:String,about:String) {
        super.init(companyNameorNickname: companyNameorNickname, email: email, password: password, userkey: userkey,about : about)
        _workArea = workArea
    }
}
