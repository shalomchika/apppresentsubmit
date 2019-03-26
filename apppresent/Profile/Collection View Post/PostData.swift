//
//  postData.swift
//  apppresent
//
//  Created by Macbook Pro on 04/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation
import Firebase

struct PostData {
    var key:String!
    var url: String!
    var caption: String!
    // nee dto add timestamp
    var timestamp: Double = 0
    var itemRef : DatabaseReference?
    var author:String!
    
    
    //give it the key 
    init(url: String, key:String, caption: String, author: String)
    {
        self.key = key
        self.url = url
        self.caption = caption
        self.itemRef = nil
        
        
    }
    
    //get the url from firebase
    init(snapshot: DataSnapshot)
    {
        key = snapshot.key
        itemRef = snapshot.ref
        
    
        var snapshotvalue = snapshot.value as? NSDictionary
        //print("THIS IS COLLECTIONS SNAPPPPPP")
        print(snapshot)
      

  
        
        if let feedcaption = snapshotvalue?["caption"] as? String {
            caption = feedcaption
            //  print(url)
        }
            
        else {
            caption = ""
        }
        
        
      
        if let imageUrl = snapshotvalue?["pathToImage"] as? String {
            url = imageUrl
            //  print(url)
        }
            
        else {
            url = ""
        }
        print("THIS IS CAPTION TEST on firebase")
       // print("THIS IS URL TEST on firebase")
      //  print(url)
       // print(key)
       // print("THIS IS CAPTION TEST on firebase")
       // print(caption)
        
        
        
        
        if let postauthor = snapshotvalue?["author"] as? String {
            author = postauthor
            //  print(url)
        }
            
        else {
            author = "set"
        }
        print("THIS IS CAPTION TEST on firebase")
        // print("THIS IS URL TEST on firebase")
        //  print(url)
        // print(key)
        // print("THIS IS CAPTION TEST on firebase")
        // print(caption)
        timestamp = snapshotvalue?["timestamp"] as? Double ?? 0
        
  
 
        
    }

    var userId: String?
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
        userId = data["userID"] as? String
        url = data["pathToImage"] as? String
        caption = data["caption"] as? String
        timestamp = data["timestamp"] as? Double ?? 0
        author = data["author"] as? String
    }

}
