//
//  CategoryViewController.swift
//  Todoey
//
//  Created by novyk on 9/4/19.
//  Copyright © 2019 novyk. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {

 //   override func viewDidLoad() {
 //       super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
  //  }

    // MARK: - Table view data source

   // override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return 0
    //}

   // override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return 0
    //}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    let realm = try! Realm()
    
    
    var categories: Results<Category>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        //let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Add yet"
        
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }

    //MARK: - Data Manipulation Methods
    
    
    func save(category: Category) {
        
        
        do {
            try realm.write() {
                realm.add(category)
            }
        } catch {
            print("Error saving categories \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        
    /*
        let request = NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch  {
            print("Error loading categories \(error)")
        }
         
 */
        tableView.reloadData()

    }
    
    
    
    

    //MARK: - Add New Categories
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            
            
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            print(textField.text!)
            
            //self.categories.append(newCategory)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.save(category: newCategory)
        
    }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
            //print(textField.text!)
            print("Now !!!")
        }
        
        
        alert.addAction(action)
        
        
        
        present(alert, animated: true, completion: nil)
    }
        
    
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        nombreCategoriaSeleccionada = (categories?[indexPath.row].name)!
        
        performSegue(withIdentifier: "goToItems", sender: self)
        print("pasar a la siguiente pantalla")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {  //por si hay varios segues
            
            let destinationVC = segue.destination as! TodoListViewController
            
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
                
            }
            
            
            //newVCItems.selected = nombreCategoriaSeleccionada
            
            
        }
    }
    
    
    var nombreCategoriaSeleccionada: String = ""

}
