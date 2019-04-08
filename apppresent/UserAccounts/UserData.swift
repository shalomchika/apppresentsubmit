//
//  UserData.swift
//  apppresent
//
//  Created by Macbook Pro on 01/02/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation
import Firebase

struct UserData {
    var key: String!
    //var userid: String!
    var profileimageurl: String!
    var email : String!
    var username: String!
    var firstname : String!
    var lastname : String!
    var fullname: String!
    var status: String!
    //var age: Int!
    var birthday: String!
    var shoesize: String!
    var clothesize: String!
   // var note: String!
    var itemRef : DatabaseReference?
    var hideAge = false
    
    
    
    
    //give it the key
    init(key: String, firstname:String,lastname:String,email: String,birthday:String, profileimageurl:String, itemRef: String, shoesize: String, clothesize: String)
    {
        self.key = key
        //self.userid = userid
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.shoesize = shoesize
        self.clothesize = clothesize
        //self.age = age
        self.birthday = birthday
        self.profileimageurl = profileimageurl 
        self.itemRef = nil
        self.fullname = "\(firstname) + \(lastname)"
        
        
    }
    
    //get the url from firebase
    init(snapshot: DataSnapshot)
    {
        key = snapshot.key
        itemRef = snapshot.ref
        
        
        var snapshotvalue = snapshot.value as? NSDictionary
        //print("THIS IS COLLECTIONS SNAPPPPPP")
        print(snapshot)
        
        
        
       /*if let  usersid = snapshotvalue?["userID"] as? String {
            userid = usersid
              print(url)
        }
        */
        
        if let  userfirstname = snapshotvalue?["firstname"] as? String {
            firstname = userfirstname
            //  print(url)
        }
            
        else {
            firstname = ""
        }
        
        if let  userlastname = snapshotvalue?["lastname"] as? String {
            lastname = userlastname
            //  print(url)
        }
            
        else {
            lastname = ""
        }
        
    
        if let username = "\(firstname ??  "") " + " " + "\(lastname ?? "" )" as? String {
            print(username)
        }
        else {
        
            username = ""
        }
        
        if let userimageurl = snapshotvalue?["profileImageUrl"] as? String {
            profileimageurl = userimageurl
            //  print(url)
        }
            
        else {
            profileimageurl = ""
        }
        
    
        
        
        if let useremail = snapshotvalue?["email"] as? String {
            email = useremail
            //  print(url)
        }
            
        else {
            email = ""
        }
        
        
      /*  if let  userage = snapshotvalue?["age"] as? Int {
            age = userage
            //  print(url)
        }
            
        else {
            age = 0
        }
 */
        
        if let  userstatus = snapshotvalue?["status"] as? String {
            status = userstatus
            //  print(url)
        }
        else {
            birthday = ""
        }
        
        if let userbirthday = snapshotvalue?["birthday"] as? String {
            // change birthday to timestamp, easier to convert to calculate
            birthday = userbirthday
            //  print(url)
        }
        else {
            birthday = ""
        }
        
        if let  userclothesize = snapshotvalue?["clothesize"] as? String {
            clothesize = userclothesize
            //  print(url)
        }
            
        else {
            clothesize = ""
        }
        
        shoesize = snapshotvalue?["shoesize"] as? String ?? ""
        
        if let data = snapshotvalue?["hideAge"] as? Bool {
            hideAge = data
        }
    }
    
    var userId: String?
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
        userId = data["userID"] as? String
        
        firstname = data["firstname"] as? String
        lastname = data["lastname"] as? String
        fullname = "\(firstname!) \(lastname!)"
       // age = data["age"] as? Int
        birthday = data["birthday"] as? String
        status = data["status"] as? String
        email = data["email"] as? String
        profileimageurl = data["profileImageUrl"] as? String
        shoesize = data ["shoesize"] as? String
        clothesize = data ["clothesize"] as? String
        hideAge = data ["hideAge"] as? Bool ?? false
    }
    
}

