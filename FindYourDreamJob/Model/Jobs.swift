//
//  Jobs.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation

class Jobs {
    private var _jobKey : String?
    private var _description : String?
    private var _title : String?
    private var _employmentType: String?
    private var _caption : String?
    private var _jobPlace : String?
    private var _timeStamp :  NSNumber?
    private var _users : User?
    var timeStamp : NSNumber!{
        return _timeStamp
    }
    var users : User!{
        if _users != nil {
            return _users
        }
        return nil
    }
    var jobKey : String!{
        return _jobKey
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
    init(jobKey:String,description:String,title:String,employmentType : String,caption : String,jobPlace:String,timeStamp : NSNumber) {
        _jobKey = jobKey
        _description = description
        _title = title
        _employmentType = employmentType
        _caption = caption
        _jobPlace = jobPlace
        _timeStamp = timeStamp
    }
    
}
