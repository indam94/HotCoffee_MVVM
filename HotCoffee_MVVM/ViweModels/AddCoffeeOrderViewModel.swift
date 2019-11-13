//
//  AddCoffeeOrderViewModel.swift
//  HotCoffee_MVVM
//
//  Created by DONGGUN LEE on 11/12/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import Foundation

struct AddCoffeeOrderViewModel{
    var name: String?
    var email: String?
    
    var types:[String]{
        return CoffeeType.allCases.map {$0.rawValue.capitalized}
    }
    
    var sizes:[String]{
        return CoffeeSize.allCases.map {$0.rawValue.capitalized}
    }
}
