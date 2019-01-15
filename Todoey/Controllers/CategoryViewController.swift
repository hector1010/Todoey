//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Veolus Desarrollo on 1/3/19.
//  Copyright © 2019 Hector Amador. All rights reserved.
//

import UIKit
import RealmSwift


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categoryArray: Results<Category>?
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(dataFilePath)
        loadCategories()
    }

    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added yet"
        
        return cell
    }
    
    
    //MARK: - Data Manipulation Methods
    
    func saveCategories(category : Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving category, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categoryArray = realm.objects(Category.self)
        tableView.reloadData()
   }
    
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {
            (action) in
            
            //What will happen once the user clicks the Add Item button on our UIAlert
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.saveCategories(category: newCategory)
        }
        
        alert.addTextField {
            (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let desitinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            desitinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    
    
}
