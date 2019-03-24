//
//  Shop.swift
//  apppresent
//
//  Created by Macbook Pro on 03/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct GiftData {
    
    var url: String!
    var description: String!
    var image: String!
    var key: String!
    var itemRef :DatabaseReference?
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
        
        if let gifturl = snapshotvalue?["url"] as? String {
            url = gifturl
            //  print(url)
        }
            
        else {
            url = ""
        }
        
        
        if let giftdescription = snapshotvalue?["description"] as? String {
            description = giftdescription
            //  print(url)
        }
            
        else {
            description = ""
        }
        print("THIS IS name TEST on firebase")
        // print("THIS IS URL TEST on firebase")
        //  print(url)
        // print(key)
        // print("THIS IS CAPTION TEST on firebase")
        // print(caption)
        
        
        if let giftimage = snapshotvalue?["imageUrl"] as? String {
            image = giftimage
            //  print(url)
        }
            
        else {
            image = ""
        }
        print("THIS IS name TEST on firebase")
        
        
        
    }
    
    var userId: String?
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
        url = data["link"] as? String
        description = data["description"] as? String ?? "url"
        image = data["imageUrl"] as? String ?? "name"
        created = data["created"] as? Double ?? 0
        
    }
}



