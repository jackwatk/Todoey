//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Jack Watkins on 10/06/2018.
//  Copyright © 2018 Jack Watkins. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCatergories()

    }

    //MARK: TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCatergoryCell", for: indexPath)
        
        
        cell.textLabel?.text  = categories[indexPath.row].name
        
        return cell

    }
    
    
//    for connecting to todolist
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
//    prep work so that the sugue takes in information from catergory
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
                
            }
        }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Catergory", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Catergory", style: .default) { (action) in
    
            
            let newCatergory = Category(context: self.context)
            
            newCatergory.name = textField.text!
            
            self.categories.append(newCatergory)
            
            self.saveCategory()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new catergory"
            textField = alertTextField
            
            print(alertTextField.text)
            print("Now")
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    
    }
    
    
    //MARK: - Tableview delegate methods - what happens when you click on table view
    
  
    //MARK: - Data Manipulation Methods
    
//    save items
    func saveCategory(){
        
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
            
            
        }
        
        self.tableView.reloadData()
    }
//  load items
    func loadCatergories(with request: NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categories = try context.fetch(request)
        } catch{
            print("error fethcing data from context \(error)")
            
        }
        tableView.reloadData()
        
    }
}

    
    
    
    

