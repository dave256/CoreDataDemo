//
//  CoreDataStack.swift
//  CoreDataDemo
//
//  Created by David M. Reed on 2/14/19.
//  Copyright © 2019 David Reed. All rights reserved.
//

import Foundation
import CoreData

let MODEL_NAME = "CoreDataDemo"

// based on: https://swifting.io/blog/2016/09/25/25-core-data-in-ios10-nspersistentcontainer/

class CoreDataStack {

    static let shared = CoreDataStack()
    private init() {}
    var errorHandler: (Error) -> Void = {_ in }

    //#1
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: MODEL_NAME)
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(String(describing: error._userInfo))")
                self?.errorHandler(error)
            }
        })
        return container
    }()

    //#2
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()

    //#3
    // Optional
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()

    //#4
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }

    //#5
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }

    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
