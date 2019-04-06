//
//  ViewController.swift
//  Todoey
//
//  Created by novyk on 4/4/19.
//  Copyright © 2019 novyk. All rights reserved.
//

import UIKit







class TodoListViewController: UITableViewController {


    
    
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Javi"
        itemArray.append(newItem)
        let newItem2 = Item()
        newItem2.title = "Find Javi"
        itemArray.append(newItem2)
        let newItem3 = Item()
        newItem3.title = "Find Javi"
        itemArray.append(newItem3)
 
        for kkk in 1...15 {
            let newItem4 = Item()
            newItem4.title = "Find Javi \(kkk)"
            itemArray.append(newItem4)

            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }


    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        /*
        if item.done {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        */
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row].title)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    // MARK - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
        
            
            let newItem = Item()
            newItem.title = textField.text!
            
            print(textField.text!)
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.tableView.reloadData()
            
            
            
        print("Success !!!")
        }
        
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            //print(textField.text!)
            print("Now !!!")
        }
        
        
        alert.addAction(action)
        

        
        present(alert, animated: true, completion: nil)
        
        
        
        
        
    }
    
    
    
}

