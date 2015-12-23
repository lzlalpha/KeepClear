//
//  Task.swift
//  KeepClear
//
//  Created by lzlalpha on 15/12/21.
//  Copyright © 2015年 lzlalpha. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
//    dynamic var id = 0
    dynamic var title = ""
    dynamic var memo = ""
    dynamic var backgroundImage = ""
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }

// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
