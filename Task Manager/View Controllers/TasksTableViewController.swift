//
//  TasksTableViewController.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 15/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import CoreData

class TasksTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, TaskCellDelegate {
    
    let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: true)
    let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
    let isDoneSortDescriptor = NSSortDescriptor(key: "isDone", ascending: true)
    
    lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")

        //Decide how to sort
        let sortDescriptor = (UserDefaults.standard.string(forKey: "sortBy") == "By Date") ? dateSortDescriptor : nameSortDescriptor
        
        fetchRequest.sortDescriptors = [isDoneSortDescriptor, sortDescriptor]
        
        guard let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else {
            fatalError("Persistent Container not found")
        }
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: "isDone", cacheName: nil)
        
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        do {
            let sortDescriptor = (UserDefaults.standard.string(forKey: "sortBy") == "By Date") ? dateSortDescriptor : nameSortDescriptor
            fetchedResultsController.fetchRequest.sortDescriptors = [isDoneSortDescriptor, sortDescriptor]
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Cannot fetch results")
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.indexTitle == "1" ? "Completed" : "Incompleted"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor(named: "TMGrey")
        
        let headerView: UITableViewHeaderFooterView  = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor(named: "TMYellow")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell else { return UITableViewCell() }

        // Set up the cell
        let task = self.fetchedResultsController.object(at: indexPath)
        cell.delegate = self
        cell.setupCell(task: task)
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let task = fetchedResultsController.object(at: indexPath)
            fetchedResultsController.managedObjectContext.delete(task)
            
            do {
                try fetchedResultsController.managedObjectContext.save()
            } catch {
                fatalError("Could not delete task")
            }
        }   
    }
    
    // MARK: - Table View delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = fetchedResultsController.object(at: indexPath)
        if let editTaskNavigationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdateTaskNavigationController") as? UINavigationController,
            let editTaskViewController = editTaskNavigationViewController.topViewController as? TaskUpdateViewController {
            editTaskViewController.task = task
            present(editTaskNavigationViewController, animated: true, completion: nil)
        }
    }
    
    // MARK: - TaskCellDelegate
    func didSetDone(task: Task, done: Bool) {
        task.isDone = done
        do {
            try fetchedResultsController.managedObjectContext.save()
        } catch {
            fatalError("Could not switch task completion")
        }
    }
    
    // MARK: - NSFetchedResultsController
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
        
        if let indexPath = indexPath, let taskCell = tableView.cellForRow(at: indexPath) as? TaskCell {
            taskCell.reload()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

}
