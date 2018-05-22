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
}
