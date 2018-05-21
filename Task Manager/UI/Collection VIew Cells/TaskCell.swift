//
//  TaskCell.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 20/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import CoreData

class TaskCell: UITableViewCell {
    static let identifier = "TaskCell"

    
    //MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var categoryColorLabel: UIView!
    @IBOutlet weak var isDone: UISwitch!
    
    //MARK: - Public Interface
    func setupCell(task: Task) {
        taskNameLabel.text = task.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy H:m"
        taskDateLabel.text = dateFormatter.string(from: task.date)
        
        categoryColorLabel?.backgroundColor = task.belongsTo.color
        
        isDone.setOn(task.isDone, animated: false)
    }
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskNameLabel?.text = nil
        taskDateLabel?.text = nil
        categoryColorLabel?.backgroundColor = nil
    }
}
