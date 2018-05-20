//
//  Category.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 15/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Category: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var color: UIColor
    
    @NSManaged var tasks: [Task]
}
