//
//  Order.swift
//  HotCoffee_MVVM
//
//  Created by DONGGUN LEE on 11/12/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable{
    case cappuccino
    case latte
    case espressoino
    case cortado
}

enum CoffeeSize: String, Codable{
    case small
    case medium
    case large
}

struct Order: Codable{
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}
