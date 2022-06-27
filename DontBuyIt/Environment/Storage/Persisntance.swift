//
//  Persisntance.swift
//  DontBuyIt
//
//  Created by Pavel Borisov on 27.06.2022.
//

import CoreData

struct PersistenceController {
    private static let container: NSPersistentContainer = {
        let returnContainer = NSPersistentContainer(name: "DontBuyIt")
        if NSClassFromString("XCTestCase") != nil {
            returnContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        returnContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
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
                // FatalError still makes sense here for most of those errors I would say..
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        returnContainer.viewContext.automaticallyMergesChangesFromParent = true
        return returnContainer
    }()
    
    static let viewContext = container.viewContext

    static func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return context
    }
}
