//
//  NotificationService.swift
//  Task Manager

import Foundation
import UIKit
import UserNotifications
import CoreData

class NotificationService {
    
    static let shared = NotificationService()
    
    var isUserEnabled = false
    var isOSEnabled = false
    
    //MARK: - Services - NotificationCenter
    func checkAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { (settings) in
            self.isOSEnabled = (settings.authorizationStatus == .authorized)
        }
    }
    
    func setupCategory() {
        //let doneAction = UNNotificationAction(identifier: "DONE_ACTION", title: "Mark as completed", options: UNNotificationActionOptions(rawValue: 0))
        let dismissAction = UNNotificationAction(identifier: "DISMISS_ACTION", title: "Dismiss", options: UNNotificationActionOptions(rawValue: 0))
        
        let taskCategory = UNNotificationCategory(identifier: "TASK_CATEGORY", actions: [dismissAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.setNotificationCategories([taskCategory])
    }
    
    //MARK: - Services - Notifications
    func scheduleNotification(task: Task) {
        //Create Content
        let content = UNMutableNotificationContent()
        content.title = task.name
        if let body = task.desc { content.body = body } else { content.body = "" }
        content.categoryIdentifier = "TASK_CATEGORY"
        
        //Setup Trigger
        let calendar = Calendar.current
        let components = calendar.dateComponents(in: .current, from: task.date)
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //Create Request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //Register the request with the system
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("Did not register notification \(task.name)")
            }
        }
    }
    
    //MARK: - Notification ON/OFF handling
    func removeActiveNotifications() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func setActiveNotifications() {
        //Get all objects from coreData
        guard let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer else {
            fatalError("Persistent Container not found")
        }
        
        let fetchRequest = NSFetchRequest<Task>(entityName: "Task")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        //Filter objects by notify and date
        fetchRequest.predicate = NSPredicate(format: "(notify != %@) AND (date > %@)", argumentArray: ["YES", Date()])
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Cannot fetch results")
        }
        
        //Set the notifications again
        if let tasks = fetchedResultsController.fetchedObjects {
            for task in tasks {
                print(task.name)
                scheduleNotification(task: task)
            }
        }
    }
    
}
