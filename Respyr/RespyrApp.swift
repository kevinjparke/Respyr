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
    let persistenceController = PersistenceController.shared
    let userViewModel: UserViewModel
    
    init() {
        Firebase.FirebaseApp.configure()
        userViewModel = UserViewModel()
    }

    var body: some Scene {
        WindowGroup {
            SignupView()
                .environmentObject(userViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
