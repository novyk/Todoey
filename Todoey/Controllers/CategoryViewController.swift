//
//  CategoryViewController.swift
//  Todoey
//
//  Created by novyk on 9/4/19.
//  Copyright © 2019 novyk. All rights reserved.
//

import UIKit
import CoreData


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

    
    
    
    var categories = [Category]()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        
        let category = categories[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    //MARK: - Data Manipulation Methods
    
    
    func saveCategories() {
        
        
        do {
            try context.save()
        } catch {
            print("Error saving categories \(error)")
        }
        
        
        tableView.reloadData()
        
    }
    
    
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        
        do {
            categories = try context.fetch(request)
        } catch  {
            print("Error loading categories \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    

    //MARK: - Add New Categories
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert
            
            
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            print(textField.text!)
            
            self.categories.append(newCategory)
            
            //self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            self.saveCategories()
        
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
        

        nombreCategoriaSeleccionada = categories[indexPath.row].name!
        
        performSegue(withIdentifier: "goToItems", sender: self)
        print("pasar a la siguiente pantalla")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToItems" {  //por si hay varios segues
            
            let destinationVC = segue.destination as! TodoListViewController
            
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories[indexPath.row]
                
            }
            
            
            //newVCItems.selected = nombreCategoriaSeleccionada
            
            
        }
    }
    
    
    var nombreCategoriaSeleccionada: String = ""

}
