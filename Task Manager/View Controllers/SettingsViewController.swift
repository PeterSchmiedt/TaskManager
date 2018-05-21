//
//  SettingsViewController.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 20/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class SettingsViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form
        +++ Section("Notification")
        <<< SwitchRow() { row in
            row.tag = "notify"
            row.title = "Enable notifications"
            //row.value =
        }
        
        +++ Section("Category")
        <<< ButtonRow() { (row: ButtonRow) -> Void in
            row.tag = "categoryManager"
            row.title = "Manage Categories"
            row.presentationMode = .show(controllerProvider: ControllerProvider.storyBoard(storyboardId: "CategoryTableViewController", storyboardName: "Main", bundle: Bundle(for: CategoryTableViewController.self)), onDismiss: nil)
        }
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
