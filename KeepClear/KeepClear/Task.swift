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
    
    dynamic var id = 0
    // 标题
    dynamic var title = ""
    // 是否提醒
    dynamic var isAlertOn = false
    // 提醒日期时间
    dynamic var alertDateTime : NSDate?
    // 备注
    dynamic var memo = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }

// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
