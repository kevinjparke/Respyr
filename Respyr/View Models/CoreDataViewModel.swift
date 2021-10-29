//
//  CoreDataViewModel.swift
//  Respyr
//
//  Created by Kevin Parke on 10/20/21.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
//    let persistenceController = PersistenceController.shared
    @Published var savedUserEntity: [UserAccount] = []
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
                print("Unresolved error \(error), \(error.userInfo)")
            } else {
                print("Store has been loaded \(String(describing: storeDescription.url))")
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
        //Create a user
        let newUser = UserAccount(context: container.viewContext)
        newUser.userID = user.id
        newUser.fullName = user.fullName
        newUser.email = user.email
        newUser.instructorID = user.instructorID
        newUser.memberSince = Date()
        newUser.userID = user.id
        
        self.saveData()
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

//MARK: - Update training centers
extension CoreDataViewModel {
    func addToTrainingCenter(_ id: String) {
        let trainingCenter = TrainingCenterData(context: container.viewContext)
        trainingCenter.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToTrainingCenters(trainingCenter)
        }
        
        self.saveData()
    }
    
    func removeFromTrainingCenter(_ data: TrainingCenterData) {
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.removeFromTrainingCenters(data)
        }
        self.saveData()
    }
}

//MARK: - Update Session IDs
extension CoreDataViewModel {
    func addToSessionID(_ id: String) {
        let sessionID = SessionIDs(context: container.viewContext)
        sessionID.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToSessionIDs(sessionID)
        }
        
        self.saveData()
    }
    
    func removeFromSessionIDs(_ data: SessionIDs){
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.removeFromSessionIDs(data)
        }
        self.saveData()
    }
}

//MARK: - Update sent requests
extension CoreDataViewModel {
    func addToSentRequests(_ id: String) {
        let sentRequest = SentRequests(context: container.viewContext)
        sentRequest.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToSentRequest(sentRequest)
        }
        
        self.saveData()
    }
    
    func removeFromSentRequests(_ data: SentRequests) {
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.removeFromSentRequest(data)
        }
        self.saveData()
    }
}

//MARK: - Update adminTC
extension CoreDataViewModel {
    func addToAdminTC(_ id: String) {
        let adminTC = AdminTC(context: container.viewContext)
        adminTC.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToAdminTC(adminTC)
        }
        self.saveData()
    }

    func removeFromAdminTC(_ data: AdminTC) {
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.removeFromAdminTC(data)
        }
        self.saveData()
    }
}

//MARK: - Update instructorTC
extension CoreDataViewModel {
    func addToInstructorTC(_ id: String) {
        let instructorTC = InstructorTC(context: container.viewContext)
        instructorTC.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToInstructorTC(instructorTC)
        }
        self.saveData()
    }
    
    func removeFromInstructorTC(_ data: InstructorTC) {
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.removeFromInstructorTC(data)
            
            self.saveData()
        }
    }
}

//MARK: - Update sessionReservations
extension CoreDataViewModel {
    func addToSessionReservations(_ id: String) {
        let sessionReservation = SessionReservations(context: container.viewContext)
        sessionReservation.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToSessionReservations(sessionReservation)
        }
        self.saveData()
    }
    
    func removeFromSessionReservation(_ data: SessionReservations) {
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.removeFromSessionReservations(data)
            
            self.saveData()
        }
    }
}

//MARK: - Update checklists
extension CoreDataViewModel {
    func addToChecklists(_ id: String) {
        let checklist = Checklists(context: container.viewContext)
        checklist.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToChecklists(checklist)
            self.saveData()
        }
        
    }
    
    func removeFromChecklist(_ data: Checklists) {
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.removeFromChecklists(data)
            self.saveData()
        }
    }
}
