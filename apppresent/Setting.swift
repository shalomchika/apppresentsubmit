//
//  Setting.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import Foundation

class Setting {
    
var didlogin : Bool
    
    
    init(didlogin: Bool) {
        self.didlogin = didlogin
         UserDefaults.standard.bool(forKey: "didlogin")
    }
    
   
}
