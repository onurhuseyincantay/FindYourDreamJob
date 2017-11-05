//
//  Database.swift
//  FindYourDreamJob
//
//  Created by onur hüseyin çantay on 24.10.2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import Firebase
let DB_BASE = Firebase.Database.database().reference()
let DB_STORAGEBASE = Firebase.Storage.storage().reference()

class Database {
    static let ds = Database()//singleton
    private var _REF_JOBS = DB_BASE.child("Jobs")
    private var _REF_PROFILE_IMAGES = DB_STORAGEBASE.child("ProfileImages")
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("Users")
    private var _REF_APPLYMENTS = DB_BASE.child("Applyments")
    private var _REF_COMPANY_USERS = DB_BASE.child("CompanyUsers")
    private var _FIR_AUTH = Firebase.Auth.auth()
    var FIR_AUTH : Auth{
        return _FIR_AUTH
    }
    var REF_PROFILE_IMAGES : StorageReference {
        return _REF_PROFILE_IMAGES
    }
    var REF_APPLYMENTS : DatabaseReference{
        return _REF_APPLYMENTS
    }
    var REF_USERS : DatabaseReference{
        return _REF_USERS
    }
    var REF_COMPANY_USERS : DatabaseReference{
        return _REF_COMPANY_USERS
    }
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    var REF_JOBS : DatabaseReference{
        return _REF_JOBS
    }
    func createFirebaseDBUser(uid : String , userData: Dictionary <String,AnyObject>) {
    REF_USERS.child(uid).updateChildValues(userData)
    }
}
