//
//  Jobs.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation

class Job {
    
    private var _CompanyName : String?
    private var _description : String?
    private var _title : String?
    private var _employmentType: String?
    private var _caption : String?
    private var _jobPlace : String?
    private var _timeStamp :  NSNumber?
    private var _companyImageURL : String?
    private var _workArea : String?
    
    var workArea : String!{
        get{
            return _workArea
        }
        set{
            _workArea = newValue
        }
    }
   
    
    var companyImageURL : String!{
        get{
            return _companyImageURL
        }
        set{
            _companyImageURL = newValue
        }
    }
    var timeStamp : NSNumber!{
        get{
            return _timeStamp
        }
        set{
            _timeStamp = newValue
        }
        
    }
    
    var companyName : String!{
        get{
            return _CompanyName
        }
        set{
            _CompanyName = newValue
        }
        
        
    }
    var caption : String!{
        get{
            return _caption
        }
        set{
            _caption = newValue
        }
    }
    var description : String!{
        get{
            return _description
        }
        set{
            _description = newValue
        }
    }
    var employmentType : String!{
        get{
            return _employmentType
        }
        set{
            _employmentType = newValue
        }
    }
    var jobPlace :String!{
        get{
            return _jobPlace
        }
        set{
            _jobPlace = newValue
        }
    }
 
    var title :String!{
        get{
            return _title
        }
        set{
            _title = newValue
        }
    }
    
    
}
