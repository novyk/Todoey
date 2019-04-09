//
//  ViewController.swift
//  Todoey
//
//  Created by novyk on 4/4/19.
//  Copyright © 2019 novyk. All rights reserved.
//

import UIKit
import CoreData







class TodoListViewController: UITableViewController {


    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    var itemArray = [Item]()
    
    //let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print("dataFilePath:  \(dataFilePath)")
        
        
       
        
        
        //loadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
        
 //       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
 //           itemArray = items
 //       }
    }


    //MARK: - Tableview Datasource Methods
    
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
    
    
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(itemArray[indexPath.row].title)
        
        
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        
        
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    //MARK: - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
        
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            
            
            print(textField.text!)
            
            self.itemArray.append(newItem)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveItems()
            
            
            
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
    
    
    
    //MARK: - Model Manipulation Methods
    
    
    func saveItems() {
        
        
        do {
            try context.save()
       } catch {
        print("Error saving context \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    

    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
    
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory?.name)!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        
        do {
            itemArray = try context.fetch(request)
        } catch  {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
    
  
    
   
    
    
    
    
    
    
}




//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    


     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        } else {
            searchBarSearchButtonClicked(searchBar)
        }
        
    }
 
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let request: NSFetchRequest<Item> = Item.fetchRequest()

        //print(searchBar.text!)
        
        
        
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        

        loadItems(with: request)
        

        
    }
    
}
