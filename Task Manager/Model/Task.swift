//
//  Task.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 15/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var date: Date
    @NSManaged var desc: String?
    @NSManaged var isDone: Bool
    @NSManaged var notify: Bool
    
    @NSManaged var belongsTo: Category
}
