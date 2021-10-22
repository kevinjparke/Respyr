//
//  CoreDataViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 10/20/21.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    let container: NSPersistentCloudKitContainer
    @Published var savedUserEntity: [UserAccount] = []

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
            }
        })
        
        fetchUser()
    }
    
    func fetchUser() {
        let request = NSFetchRequest<UserAccount>(entityName: "UserAccount")
        
        do {
            self.savedUserEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching", error)
        }
        
    }
    
    func addUser(user: User) {
        let newUser = UserAccount(context: container.viewContext)
        newUser.userID = user.id
        newUser.fullName = user.fullName
        newUser.email = user.email
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchUser()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
}
