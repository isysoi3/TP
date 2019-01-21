//
//  AppDelegate.swift
//  Vitebsk Mus
//
//  Created by Ilya Sysoi on 5/4/18.
//  Copyright © 2018 isysoi. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Museums")
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
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        initCoreData()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = MapViewController()
        window!.rootViewController = homeViewController
        window!.makeKeyAndVisible()
        
        return true
    }

    private func initCoreData() {
        let items: [(name: String, location:(Double, Double))] = [(("Vitebsk"), (55.1904, 30.2049)),
                                                                  (("Liozna"), (55.0166666, 30.7999968)),
                                                                  (("Ruba"), (55.3022222322, 30.3116666767)),
                                                                  (("Beshankovichy"), (55.0333332, 29.4499982))]
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let cityFetchRequest = NSFetchRequest<CityInfo>(entityName: "CityInfo")
        let museumsFetchRequest = NSFetchRequest<MuseumsInfo>(entityName: "MuseumsInfo")
        do
        {
            let tmp = try context.fetch(cityFetchRequest)
            var cites = tmp as [NSManagedObject]
            if cites.count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: "CityInfo", in: context)
                for item in items {
                    let newInfo = NSManagedObject(entity: entity!, insertInto: context)
                    newInfo.setValue(item.name, forKey: "name")
                    newInfo.setValue(item.location.0, forKey: "locationLongitude")
                    newInfo.setValue(item.location.1, forKey: "locationLatitude")
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                    }
                }
            }
            
            let tmp1 = try context.fetch(museumsFetchRequest)
            var museums = tmp1 as [NSManagedObject]
            if museums.count == 0 {
                let entity = NSEntityDescription.entity(forEntityName: "MuseumsInfo", in: context)
                for item in items {
                    for i in 0...5 {
                        let newInfo = NSManagedObject(entity: entity!, insertInto: context)
                        newInfo.setValue(item.name, forKey: "nameID")
                        newInfo.setValue("Test\(i)", forKey: "name")
                        do {
                            try context.save()
                        } catch {
                            print("Failed saving")
                        }
                    }
                }
            }
        }
        catch let error as NSError
        {
            print("Data loading error: \(error)")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
         saveContext()
    }


}

