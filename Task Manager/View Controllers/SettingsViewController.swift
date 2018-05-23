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
            row.value = NotificationService.shared.isUserEnabled
            row.disabled = Condition.function(["notify"], { form in
                return !NotificationService.shared.isOSEnabled
            })
            }.onChange { row in
                if let switchRowValue = row.value {
                    NotificationService.shared.isUserEnabled = switchRowValue //Change accordingly to user settings
                }
            }
            
        +++ Section("Order")
        <<< PushRow<String>() { row in
            row.tag = "order"
            row.title = "Order by"
            row.value = UserDefaults.standard.string(forKey: "orderBy")
            row.options = ["By Date", "By Name"]
            row.add(rule: RuleRequired())
        }.onChange { row in
            UserDefaults.standard.set(row.value, forKey: "orderBy")
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
