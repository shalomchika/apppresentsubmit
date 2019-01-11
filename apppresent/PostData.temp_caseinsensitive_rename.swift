//
//  postData.swift
//  apppresent
//
//  Created by Macbook Pro on 04/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct PostData {
    let key:String!
    let url: String!
    let itemRef : DatabaseReference?
    
    
    //give it the key 
    init(url: String, key:String)
    {
        self.key = key
        self.url = url
        self.itemRef = nil
        
    }
    
    //get the url from firebase
    init(snapshot: DataSnapshot)
    {
        key = snapshot.key
        itemRef = snapshot.ref
        
        var snapshotvalue = snapshot.value as? NSDictionary
        print("THIS IS COLLECTIONS SNAPPPPPP")
        print(snapshot)
        
        if let imageUrl = snapshotvalue?["url"] as? String {
            url = imageUrl
          //  print(url)
        }
        
        else {
            url = ""
        }
        print("THIS IS URL FINAL")
        print(url)
        print(key)
    }

}
