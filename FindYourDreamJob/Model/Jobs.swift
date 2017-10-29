//
//  Jobs.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation

class Jobs {
    private var _CompanyName : String?
    private var _description : String?
    private var _title : String?
    private var _employmentType: String?
    private var _caption : String?
    private var _jobPlace : String?
    private var _timeStamp :  NSNumber?
    private var _users : User?
    private var _companyImageURL : String?
    var companyImageURL : String!{
        return _companyImageURL
    }
    var timeStamp : NSNumber!{
        return _timeStamp
    }
    var users : User!{
        if _users != nil {
            return _users
        }
        return nil
    }
    var companyName : String!{
        return _CompanyName
    }
    var caption : String!{
        return _caption
    }
    var description : String!{
        return _description
    }
    var employmentType : String!{
        return _employmentType
    }
    var jobPlace :String!{
        return _jobPlace
    }
 
    var title :String!{
        return _title
    }
    init(companyName:String,description:String,title:String,employmentType : String,caption : String,jobPlace:String,timeStamp : NSNumber,imageURl:String) {
        _CompanyName = companyName
        _description = description
        _title = title
        _employmentType = employmentType
        _caption = caption
        _jobPlace = jobPlace
        _timeStamp = timeStamp
        _companyImageURL = imageURl
    }
    
}
