//
//  CoreDataViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 10/20/21.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Respyr")
        //Detect changes from iCloud
        container.viewContext.automaticallyMergesChangesFromParent = true
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Store has been loaded \(String(describing: storeDescription.url))")
            }
        })
    }
}
