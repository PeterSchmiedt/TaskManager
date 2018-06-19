//
//  CategoryUpdateViewController.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 21/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import CoreData
import Eureka
import ColorPickerRow

class CategoryUpdateViewController: FormViewController, NSFetchedResultsControllerDelegate {
    
    var category: Category?
    
    var appDelegate : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = category {
            title = "Edit Category"
        } else {
            title = "New Category"
        }
        
        form
        +++ TMSection()
        <<< TextRow() { row in
            row.tag = "name"
            row.title = "Name"
            row.placeholder = "Enter Category Name"
            row.value = category?.name
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
        
        <<< InlineColorPickerRow() { row in
            row.tag = "color"
            row.title = "Color"
            row.value = category?.color
            row.add(rule: RuleRequired())
        }
    }
    
    func presentValidationError(error: String, row: BaseRow) {
        let alertController = UIAlertController(title: "Validation error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
            row.baseCell.cellBecomeFirstResponder()
        }))
        present(alertController, animated: true)
    }
    
    //MARK: - Navigation
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard
            let nameRow = form.rowBy(tag: "name") as? TextRow,
            let colorRow = form.rowBy(tag: "color") as? InlineColorPickerRow
            else {
                fatalError("Form inconsistency")
        }
        
        //Name and Color validation
        
        form.validate()
        
        guard nameRow.isValid else {
            presentValidationError(error: "Invalid Name", row: nameRow)
            return
        }
        
        guard colorRow.isValid else {
            presentValidationError(error: "Invalid Color", row: colorRow)
            return
        }
        
        // All validated. Save!
        let saveCategory = category ?? Category(context: appDelegate.persistentContainer.viewContext)
        
        saveCategory.name = nameRow.value!
        saveCategory.color = colorRow.value!
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
            appDelegate.persistentContainer.viewContext.refreshAllObjects()
        } catch {
            fatalError("Can't save task.")
        }
        
        dismiss(animated: true, completion: nil)
    }
}
