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
    
    dynamic var title = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
