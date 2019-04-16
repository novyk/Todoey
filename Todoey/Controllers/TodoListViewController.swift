//
//  ViewController.swift
//  Todoey
//
//  Created by novyk on 4/4/19.
//  Copyright © 2019 novyk. All rights reserved.
//

import UIKit
import RealmSwift







class TodoListViewController: UITableViewController {

    //var itemArray = [Item]()
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
    
    
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    
    
    //let defaults = UserDefaults.standard
    
    //let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    //let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //print("dataFilePath:  \(dataFilePath)")
        
        
       
        
        
        //loadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
        
 //       if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
 //           itemArray = items
 //       }
    }


    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        if let item = todoItems?[indexPath.row] {

            cell.textLabel?.text = item.title
            
            
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
                cell.textLabel?.text = "No items added"
        }
        

        

        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    
                    
                    //realm.delete(item)        borrado en realm
                    
                    item.done = !item.done
                }
            } catch {
                    print("error updating done status: \(error)")
            }
        }
        
        tableView.reloadData()
        
        // print(itemArray[indexPath.row].title)
        
        
        //context.delete(itemArray[indexPath.row])
        //todoItems.remove(at: indexPath.row)
        
        
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        //saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    //MARK: - Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
        
            
            
            
            if let currentCategory = self.selectedCategory {
                
                do {
                
                
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                }
                } catch {
                
                   print("Error saving new items, \(error)")
                
                
                
                }
                
            }
            
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
    
    
    
    //MARK: - Model Manipulation Methods
    
    
    func saveItems() {
        
     
        
    }
    
    

    func loadItems() {
    
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
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

        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
        /*
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        //print(searchBar.text!)
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request)
        */

        
    }
    
}

