//
//  Jobs.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation

class Jobs {
    private var _jobKey : String!
    private var _description : String!
    private var _summary : String!
    private var _title : String!
    private var _employmentType: String!
    private var _caption : String!
    private var _jobPlace : String!
    var jobKey : String!{
        return _jobKey
    }
    var caption : String{
        return _caption
    }
    var description : String!{
        return _description
    }
    var employmentType : String!{
        return _employmentType
    }
    var jobPlace :String{
        return _jobPlace
    }
    var summary :String!{
        return _summary
    }
    var title :String!{
        return _title
    }
    init(jobKey:String,description:String,summary:String,title:String,employmentType : String,caption : String,jobPlace:String) {
        _jobKey = jobKey
        _summary = summary
        _description = description
        _title = title
        _employmentType = employmentType
        _caption = caption
        _jobPlace = jobPlace
    }
    
}
