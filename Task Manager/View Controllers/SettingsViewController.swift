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
        +++ Section()
        
    }
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
