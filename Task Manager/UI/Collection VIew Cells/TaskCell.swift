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

    var task: Task?
    
    //MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var categoryColorView: UIView!
    @IBOutlet weak var isDone: UISwitch!
    
    //MARK: - Public Interface
    func setupCell(task: Task) {
        taskNameLabel.text = task.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy HH:mm"
        taskDateLabel.text = dateFormatter.string(from: task.date)
        
        categoryColorView?.backgroundColor = task.belongsTo.color
        
        isDone.setOn(task.isDone, animated: false)
        
        self.task = task
    }
    
    func reload() {
        guard let task = self.task else { return }
        setupCell(task: task)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = categoryColorView.backgroundColor
        super.setSelected(selected, animated: animated)
        
        if selected {
            categoryColorView.backgroundColor = color
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = categoryColorView.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            categoryColorView.backgroundColor = color
        }
    }
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskNameLabel?.text = nil
        taskDateLabel?.text = nil
        categoryColorView?.backgroundColor = nil
    }
}
