//
//  Category.swift
//  Todoey
//
//  Created by Veolus Desarrollo on 1/3/19.
//  Copyright © 2019 Hector Amador. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
