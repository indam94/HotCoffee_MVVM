//
//  OrdersTableViewController.swift
//  HotCoffee_MVVM
//
//  Created by DONGGUN LEE on 11/12/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrder()
    }
    
    private func populateOrder(){
        
        guard let coffeeOrderURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else{
            fatalError("URL IS INCORRECT!")
            return
        }
        
        let resource = Resource<[Order]>(url:coffeeOrderURL)
        
        WebService().load(resource: resource){ result in
            
            switch(result){
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
}
