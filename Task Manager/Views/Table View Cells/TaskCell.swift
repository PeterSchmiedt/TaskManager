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
    @IBOutlet weak var taskDetailLabel: UILabel!
    @IBOutlet weak var taskDateLabel: UILabel!
    @IBOutlet weak var categoryColorView: BallView!
    @IBOutlet weak var isDoneButton: UIButton!
    
    //MARK: - Public Interface
    func setupCell(task: Task) {
        taskNameLabel.text = task.name
        taskDetailLabel.text = task.desc
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d.M.yyyy HH:mm"
        taskDateLabel.text = dateFormatter.string(from: task.date)
        
        categoryColorView?.color = task.belongsTo.color
        
        isDoneButton.isSelected = task.isDone
        
        self.task = task
    }
    
    func reload() {
        guard let task = self.task else { return }
        setupCell(task: task)
    }
    
    //MARK: - LifeCycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        taskNameLabel?.text = nil
        taskDateLabel?.text = nil
        categoryColorView?.color = .clear
    }
    
    // MARK: - Actions
    @IBAction func doneAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        task?.isDone = sender.isSelected
    }
    
}
