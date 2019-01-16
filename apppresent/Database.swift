//
//  Database.swift
//  apppresent
//
//  Created by Macbook Pro on 16/01/2019.
//  Copyright © 2019 Macbook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase

enum DatabaseNode: String {
    case followers, following, users
    static func getDb(_ node: DatabaseNode) -> DatabaseReference {
        let db = Database.database().reference().child(node.rawValue)
        return db
    }
}
