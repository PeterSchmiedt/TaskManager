//
//  TaskUpdateViewController.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 15/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import Eureka

class TaskUpdateViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Task")
            <<< TextRow() { row in
                row.tag = "name"
                row.title = "Name"
            }
            <<< DateTimeRow() { row in
                row.tag = "date"
                row.title = "Date"
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
