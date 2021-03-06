//
//  AppDelegate.swift
//  Task Manager

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //seed the 4 default categories
        let moc = self.persistentContainer.viewContext
        let categoryFetch = NSFetchRequest<Category>(entityName: "Category")
        do {
            let categories = try moc.fetch(categoryFetch)
            if categories.count == 0 {
                seedData()
            }
        } catch {
            fatalError("Failed to fetch categories: \(error)")
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { granted, error in
            if granted {
                print("Approval granted to send notifications")
                NotificationService.shared.isOSEnabled = true
            } else {
                NotificationService.shared.isOSEnabled = false
                print(error ?? "Default notification error")
            }
        }
        
        NotificationService.shared.isUserEnabled = UserDefaults.standard.bool(forKey: "isUserEnabled") //load
        
        if (UserDefaults.standard.string(forKey: "sortBy") == nil) {
            UserDefaults.standard.set("By Date", forKey: "sortBy")
            UserDefaults.standard.synchronize()
        }
        
        NotificationService.shared.setupCategory()
        
        // Print all fonts - temporary
        //UIFont.printAllFonts()
        
        // Set up appearance
        setUpAppearance()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        UserDefaults.standard.set(NotificationService.shared.isUserEnabled, forKey: "isUserEnabled") //save
        UserDefaults.standard.synchronize()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        NotificationService.shared.isUserEnabled = UserDefaults.standard.bool(forKey: "isUserEnabled") //load
        
        NotificationService.shared.checkAuthorization()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        UserDefaults.standard.set(NotificationService.shared.isUserEnabled, forKey: "isUserEnabled") //save
        UserDefaults.standard.synchronize()
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Task_Manager")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let moc = persistentContainer.viewContext
        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: - Core Data Seed
    func seedCategoryData(name: String, color: UIColor) {
        let category = NSEntityDescription.insertNewObject(forEntityName: "Category", into: persistentContainer.viewContext) as! Category
        category.name = name
        category.color = color
    }
    
    func seedData() {
        seedCategoryData(name: "Important", color: UIColor.red)
        seedCategoryData(name: "School", color: UIColor.blue)
        seedCategoryData(name: "Work", color: UIColor.green)
        seedCategoryData(name: "TODO", color: UIColor.orange)
        
        saveContext()
    }

}
