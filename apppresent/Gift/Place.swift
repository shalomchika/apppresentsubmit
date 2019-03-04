//
//  Place.swift
//  apppresent
//
//  Created by Macbook Pro on 03/03/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct Place {
    
    var url: String!
    var name: String!
    var key: String!
    var itemRef :DatabaseReference?
    
    init(url: String, name: String, key: String, itemRef: String) {
        self.url = url
        self.name = name
        self.key = key
        self.itemRef = nil

    }
    
    init(snapshot: DataSnapshot)
    {
        key = snapshot.key
        itemRef = snapshot.ref

        var snapshotvalue = snapshot.value as? NSDictionary
    
        if let placeimage = snapshotvalue?["url"] as? String {
            url = placeimage
            //  print(url)
        }
            
        else {
            url = ""
        }
        
        
        if let placename = snapshotvalue?["name"] as? String {
            name = placename
            //  print(url)
        }
            
        else {
            url = ""
        }
        print("THIS IS name TEST on firebase")
        // print("THIS IS URL TEST on firebase")
        //  print(url)
        // print(key)
        // print("THIS IS CAPTION TEST on firebase")
        // print(caption)
     
        
        
        
    }
    
    var userId: String?
    init(rawData: Any) {
        guard let data = rawData as? [String: Any] else { return }
        userId = data["userID"] as? String
        url = data["image"] as? String ?? "url"
        name = data["name"] as? String ?? "name"
        
    }
}
