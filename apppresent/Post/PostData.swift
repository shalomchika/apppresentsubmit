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
    init(url: String, key:String, caption: String)
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
      

        /* listen for caption changes
 
 
 MyRoom.on('value', function(snapshot) {
 var val = snapshot.val();
 alert(JSON.stringify(val)); // {Name: 'This is my room', Owner: 'frank', Marker1:'foo'}
 alert(val.Marker1); // foo
 });
 */
        /*
        if let imageUrl = snapshotvalue?["url"] as? String {
            url = imageUrl
          //  print(url)
        }
        
        else {
            url = ""
        }
        */
        
      
        if let imageUrl = snapshotvalue?["pathToImage"] as? String {
            url = imageUrl
            //  print(url)
        }
            
        else {
            url = ""
        }
        print("THIS IS CAPTION TEST on firebase")
        print("THIS IS URL TEST on firebase")
        print(url)
        print(key)
        
    }

}
