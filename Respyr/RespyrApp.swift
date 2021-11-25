//
//  RespyrApp.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import SwiftUI
import Firebase

@main
struct RespyrApp: App {
//    let persistenceController = PersistenceController.shared
    let userViewModel: UserViewModel
    let coreDataViewModel: CoreDataViewModel
    let trainingCenterViewModel: TrainingCenterViewModel
    let sessionStore: SessionStore
    
    init() {
        Firebase.FirebaseApp.configure()
        userViewModel = UserViewModel()
        coreDataViewModel = CoreDataViewModel()
        sessionStore = SessionStore()
        trainingCenterViewModel = TrainingCenterViewModel(sessionStore: sessionStore)
    }

    var body: some Scene {
        WindowGroup {
            SignupView()
                .environmentObject(userViewModel)
                .environmentObject(coreDataViewModel)
                .environmentObject(trainingCenterViewModel)
        }
    }
}
