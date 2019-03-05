//
//  Category.swift
//  Task Manager

import Foundation
import UIKit
import CoreData

class Category: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var color: UIColor
    
    @NSManaged var tasks: [Task]
}
