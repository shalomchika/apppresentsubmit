//
//  PoolData.swift
//  CountdownLabel
//
//  Created by Macbook Pro on 25/03/2019.
//


//
//  Shop.swift
//  apppresent
//
//  Created by Macbook Pro on 03/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation
import Firebase

struct PoolData {
    
    var link: String!
    var key: String!
    var itemRef: DatabaseReference?
    var created: Double = 0
    /*
     init(url:String, name:String, key:String, itemRef:String) {
     self.key = key
     self.itemRef = nil
     self.url = url
     self.name = name
     }
     */
    init(snapshot: DataSnapshot)
    {
        key = snapshot.key
        itemRef = snapshot.ref
        
        var snapshotvalue = snapshot.value as? NSDictionary
        
        if let poollink = snapshotvalue?["link"] as? String {
            link = poollink
            //  print(url)
        }
            
        else {
            link = ""
        }
        
        
        if let poolcreated = snapshotvalue?["created"] as? Double {
            
            created = poolcreated
            //  print(url)
        }
            
        else {
            
            created = 0
        }
        print("THIS IS name TEST on firebase")
        // print("THIS IS URL TEST on firebase")
        //  print(url)
        // print(key)
        // print("THIS IS CAPTION TEST on firebase")
        // print(caption)
        
        /*
        if let poolowner = snapshotvalue?["owner"] as? Double {
            
            owner = poolowner
            //  print(url)
        }
            
        else {
            
            owner = ""
        }
        print("THIS IS name TEST on firebase")
        
        
        */
    }
    
    var userId: String?
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
        link = data["link"] as? String
        created = data["created"] as? Double ?? 0
     
        
    }
}



