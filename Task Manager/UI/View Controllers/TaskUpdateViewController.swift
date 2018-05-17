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
    
    var taskId = 1 //TODO: get the data from the previous viewController or create blank
    
    lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        //fetchRequest.predicate = NSPredicate(format: "id == %@", taskId) //get the task by ID
        let idSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [idSortDescriptor]
        
        guard let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else {
            fatalError("Persistent Container not found")
        }
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: What if we want a new task? this will always produce a fatal error
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Cannot fetch results")
        }
        
        //let entity = NSEntityDescription.entity(forEntityName: "Task", in: fetchedResultsController.managedObjectContext)!
        let newTask = NSEntityDescription.insertNewObject(forEntityName: "Task", into: fetchedResultsController.managedObjectContext) as! Task
        
        form +++ Section()
            <<< CheckRow() { row in
                row.tag = "isDone"
                row.title = "Mark as Done"
                }.onChange() { row  in
                    row.title = (row.title == "Mark as Done") ? "Task Completed" : "Mark as Done"
                    row.updateCell()
                    //newTask.setValue(row.value, forKey: "isDone")
            }
            
            +++ Section("Task")
            <<< TextRow() { row in
                row.tag = "name"
                row.title = "Name"
                row.placeholder = "Enter Task Name"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
            }.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }.onChange() { row in
                //newTask.setValue(row.value, forKey: "name")
            }
            
            <<< TextAreaRow() { row in
                row.tag = "desc"
                row.title = "Description"
                row.placeholder = "Description"
            }
            
            +++ Section("Notification")
            <<< DateTimeRow() { row in
                row.tag = "date"
                row.title = "Date"
                row.value = Date()
            }
            
            <<< SwitchRow() { row in
                row.tag = "notify"
                row.title = "Recieve notification"
            }
            
            +++ Section("Category")
            <<< PushRow<String>() { row in
                row.tag = "category"
                row.title = "Category"
                row.value = "TODO" //TODO: connect to model
                row.options = ["TODO", "YOLO", "HASHTAG"] //TODO: connect to model
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        //TODO: Save to CoreData
        do {
            try fetchedResultsController.managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
