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
        +++ Section()
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
        }
    }
}
