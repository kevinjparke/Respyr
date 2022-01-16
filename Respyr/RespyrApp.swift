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
    let sessionStore: SessionStore 
    let userViewModel: UserViewModel
    let coreDataViewModel: CoreDataViewModel
    let trainingCenterViewModel: TrainingCenterViewModel
    let alertManager: AlertViewModel
    
    init() {
        Firebase.FirebaseApp.configure()
        sessionStore = SessionStore.shared
        userViewModel = UserViewModel(sessionStore: sessionStore)
        coreDataViewModel = CoreDataViewModel()
        alertManager = AlertViewModel()
        trainingCenterViewModel = TrainingCenterViewModel(sessionStore: sessionStore)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionStore)
                .environmentObject(userViewModel)
                .environmentObject(coreDataViewModel)
                .environmentObject(trainingCenterViewModel)
            
//            if sessionStore.auth.isValidated {
//                ProfileView()
//                    .environmentObject(userViewModel)
//                    .environmentObject(coreDataViewModel)
//                    .environmentObject(trainingCenterViewModel)
//            } else {
//                SignupView()
//                    .environmentObject(userViewModel)
//                    .environmentObject(coreDataViewModel)
//                    .environmentObject(trainingCenterViewModel)
//            }
        }
    }
}
