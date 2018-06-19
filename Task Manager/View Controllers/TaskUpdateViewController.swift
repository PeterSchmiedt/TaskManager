//
//  TaskUpdateViewController.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 15/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class TaskUpdateViewController: FormViewController, NSFetchedResultsControllerDelegate {
    
    var task: Task?
    
    var appDelegate : AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = task {
            title = "Edit Task"
        } else {
            title = "New Task"
        }
        
        tableView.backgroundColor = UIColor.clear
        
        form +++ Section()
        <<< CheckRow() { row in
            row.tag = "isDone"
            row.title = "Mark as Done"
            row.value = task?.isDone ?? false
            }.onChange() { row  in
                row.title = (row.title == "Mark as Done") ? "Task Completed" : "Mark as Done"
                row.updateCell()
        }
            
        +++ TMSection("Task")
        <<< TextRow() { row in
            row.tag = "name"
            row.title = "Name"
            row.placeholder = "Enter Task Name"
            row.placeholderColor = UIColor(named: "TMGrey40")
            row.value = task?.name
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }.cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
            
        <<< TextAreaRow() { row in
            row.tag = "desc"
            row.title = "Description"
            row.value = task?.desc
            row.placeholder = "Description"
            row.textAreaHeight = .dynamic(initialTextViewHeight: 70)
        }
            
        +++ TMSection("Notification")
        <<< DateTimeRow() { row in
            row.tag = "date"
            row.title = "Date"
            row.value = task?.date ?? Date()
        }
        
        <<< SwitchRow() { row in
            row.tag = "notify"
            row.title = "Recieve notification"
            row.value = task?.notify ?? false
            row.disabled = Condition.function(["notify"], { form in
                return !(NotificationService.shared.isUserEnabled && NotificationService.shared.isOSEnabled)
            })
        }
        
        +++ TMSection("Category")
        <<< PushRow<Category>() { row in
            row.tag = "category"
            row.title = "Category"
            row.value = task?.belongsTo
            row.noValueDisplayText = "Select category"
            row.displayValueFor = { category in
                return category?.name
            }
            row.add(rule: RuleRequired())
            row.options = fetchCategories()
            }.onPresent({from, to in
                var header = HeaderFooterView<TMHeaderView>(.nibFile(name: "TMHeaderView", bundle: nil))
                header.height = {30}
                
                let _ = to.view //invoke viewDidLoad()
                to.form[0].header = header
            })
    }
    
    func fetchCategories() -> [Category] {
        let categoryFetch = NSFetchRequest<Category>(entityName: "Category")
        do {
            return try appDelegate.persistentContainer.viewContext.fetch(categoryFetch)
        } catch {
            fatalError("Failed to fetch categories: \(error)")
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
            let dateRow = form.rowBy(tag: "date") as? DateTimeRow,
            let doneRow = form.rowBy(tag: "isDone") as? CheckRow,
            let nameRow = form.rowBy(tag: "name") as? TextRow,
            let descRow = form.rowBy(tag: "desc") as? TextAreaRow,
            let notifyRow = form.rowBy(tag: "notify") as? SwitchRow,
            let categoryRow = form.rowBy(tag: "category") as? PushRow<Category>
            else {
                fatalError("Form inconsistency")
        }
        
        // We only have to validate Date, Name and category. All others have valid defaults
        
        form.validate()
        
        guard dateRow.isValid else {
            presentValidationError(error: "Invalid date", row: dateRow)
            return
        }
        
        guard nameRow.isValid else {
            presentValidationError(error: "Invalid name", row: nameRow)
            return
        }
        
        guard categoryRow.isValid else {
            presentValidationError(error: "Invalid category", row: categoryRow)
            return
        }
        
        // All validated. Save!
        let saveTask = task ?? Task(context: appDelegate.persistentContainer.viewContext)
        saveTask.date = dateRow.value!
        saveTask.desc = descRow.value
        saveTask.isDone = doneRow.value!
        saveTask.name = nameRow.value!
        saveTask.notify = notifyRow.value!
        saveTask.belongsTo = categoryRow.value!
        
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch {
            fatalError("Can't save task.")
        }
        
        //Create notification if there is one
        if saveTask.notify {
            NotificationService.shared.scheduleNotification(task: saveTask)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}
