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
    private var _workArea : String!
    
    var jobKey : String!{
        return _jobKey
    }
    var description : String!{
        return _description
    }
    var summary :String!{
        return _summary
    }
    var workArea :String!{
        return _workArea
    }
    init(jobKey:String,description:String,summary:String,workArea:String) {
        _jobKey = jobKey
        _summary = summary
        _description = description
        _workArea = workArea
    }
    
}
