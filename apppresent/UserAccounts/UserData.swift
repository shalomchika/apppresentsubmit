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
        
        if let userimageurl = snapshotvalue?["pathToImage"] as? String {
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
        
        
        if let  usershoesize = snapshotvalue?["shoesize"] as? String {
            shoesize = usershoesize
            //  print(url)
        }
            
        else {
            shoesize = ""
        }
        
        
        // I created the user data structure, but Im not sure how to adapt it to order the posts like we did in the profile page.
        // also I got the kingfisher pod and the code shows no error but its not working
       // I need to use the data structure for it to work? I was trying to order the posts in the feed like the profile. But i havent used the data structure yet. 
        print("THIS IS CAPTION TEST on firebase")
        // print("THIS IS URL TEST on firebase")
        //  print(url)
        // print(key)
        // print("THIS IS CAPTION TEST on firebase")
        // print(caption)
       // timestamp = snapshotvalue?["timestamp"] as? Double ?? 0
        
        
        
    }
    
    var userId: String?
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
       // userid = data["userID"] as? String
        
        firstname = data["firstname"] as? String
        lastname = data["lastname"] as? String
        fullname = "\(firstname!) \(lastname!)"
       // age = data["age"] as? Int
        birthday = data["birthday"] as? String
        status = data["status"] as? String
        email = data["email"] as? String
        profileimageurl = data["url"] as? String
        shoesize = data ["shoesize"] as? String
        clothesize = data ["clothesize"] as? String
        
        //timestamp = data["timestamp"] as? Double ?? 0
    }
    
}

