//
//  Task.swift
//  Task Manager

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
