//
//  NotificationService.swift
//  Task Manager
//
//  Created by Peter Schmiedt on 21/05/2018.
//  Copyright © 2018 Peter Schmiedt. All rights reserved.
//

import Foundation
import UserNotifications

class NotificationService {
    
    static let shared = NotificationService()
    
    var isUserEnabled = false
    var isOSEnabled = false
    
    //MARK - Services
    func checkAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { (settings) in
            self.isOSEnabled = (settings.authorizationStatus == .authorized)
        }
    }
    
    func scheduleNotification(name: String, desc: String?, at date: Date) {
        //Create Content
        let content = UNMutableNotificationContent()
        content.title = name
        if let body = desc { content.body = body } else { content.body = "" }
        
        //Setup Trigger
        let calendar = Calendar.current
        let components = calendar.dateComponents(in: .current, from: date)
        let dateComponents = DateComponents(calendar: Calendar.current, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        //Create Request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        //Register the request with the system
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("Did not register notification \(name)")
            }
        }
    }
    
}
