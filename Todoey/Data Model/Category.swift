//
//  Category.swift
//  Todoey
//
//  Created by novyk on 10/4/19.
//  Copyright © 2019 novyk. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
