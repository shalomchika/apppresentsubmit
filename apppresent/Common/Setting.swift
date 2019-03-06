//
//  Setting.swift
//  apppresent
//
//  Created by Macbook Pro on 10/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseAuth

class Setting {
    static var didLogin: Bool {
        get {
            return UserDefaults.standard.value(forKey: "didLogin") as? Bool ?? false
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "didLogin")
        }
    }
    
    static var myId: String? {
        return Auth.auth().currentUser?.uid
    }
   
}

func hideKeyboard(){
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
}

let padding: CGFloat = 24
