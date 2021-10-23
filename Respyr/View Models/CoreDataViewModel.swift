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
        //Create a user
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
    
    func addToTrainingCenter(_ id: String) {
        let trainingCenter = TrainingCenterData(context: container.viewContext)
        trainingCenter.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToTrainingCenters(trainingCenter)
        }
        
        self.saveData()
    }
    
    func addToSessionID(_ id: String) {
        let sessionID = SessionIDs(context: container.viewContext)
        sessionID.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToSessionIDs(sessionID)
        }
        
        self.saveData()
    }
    
    func addToSentRequests(_ id: String) {
        let sentRequest = SentRequests(context: container.viewContext)
        sentRequest.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToSentRequest(sentRequest)
        }
        
        self.saveData()
    }
    
    func addToAdminTC(_ id: String) {
        let adminTC = AdminTC(context: container.viewContext)
        adminTC.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToAdminTC(adminTC)
        }
        self.saveData()
    }
    
    func addToInstructorTC(_ id: String){
        let instructorTC = InstructorTC(context: container.viewContext)
        instructorTC.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToInstructorTC(instructorTC)
        }
        self.saveData()
    }
    
    func addToSessionReservations(_ id: String) {
        let sessionReservation = SessionReservations(context: container.viewContext)
        sessionReservation.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToSessionReservations(sessionReservation)
        }
        self.saveData()
    }
    
    func addToChecklists(_ id: String) {
        let checklists = Checklists(context: container.viewContext)
        checklists.id = id
        
        if !savedUserEntity.isEmpty {
            savedUserEntity.first!.addToChecklists(checklists)
        }
        self.saveData()
    }
    
}
