//
//  Item.swift
//  Todoey
//
//  Created by novyk on 5/4/19.
//  Copyright © 2019 novyk. All rights reserved.
//

import Foundation



//class Item: Encodable, Decodable {
class Item: Codable {
    var title: String = ""
    var done: Bool = false
}
