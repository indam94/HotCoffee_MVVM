//
//  AddOrderViewController.swift
//  HotCoffee_MVVM
//
//  Created by DONGGUN LEE on 11/12/19.
//  Copyright © 2019 DONGGUN LEE. All rights reserved.
//

import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var delegate: AddCoffeeOrderDelegate?
    
    private var vm = AddCoffeeOrderViewModel()
    private var coffeeSizesSegmentCotrol: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
    }
    
    private func setupUI(){
        self.coffeeSizesSegmentCotrol = UISegmentedControl(items: self.vm.sizes)
        self.coffeeSizesSegmentCotrol.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentCotrol)
        
        self.coffeeSizesSegmentCotrol.topAnchor.constraint(equalTo: self.tableView.bottomAnchor, constant: 20).isActive = true
        self.coffeeSizesSegmentCotrol.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        
        cell.textLabel?.text = self.vm.types[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    @IBAction func close(_ sender: Any) {
        
        if let delegate = self.delegate{
            delegate.addCoffeeOrderViewControllerDidClose(controller: self)
        }
        
    }
    @IBAction func save(_ sender: Any) {
        
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.coffeeSizesSegmentCotrol.titleForSegment(at: self.coffeeSizesSegmentCotrol.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else{
            fatalError("Error in Selecting Coffee")
        }
        
        self.vm.name = name
        self.vm.email = email
        self.vm.selectedType = self.vm.types[indexPath.row]
        self.vm.selectedSize = selectedSize
        
        WebService().load(resource: Order.create(vm: self.vm)){
            result in
            
            switch result {
            case .success(let order):
                
                if let order = order, let delegate = self.delegate{
                    DispatchQueue.main.async {
                        delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
                    }
                }
                
                print(order)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
