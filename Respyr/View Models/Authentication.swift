//
//  Authentication.swift
//  Respyr
//
//  Created by Kevin Parke on 1/3/22.
//

import SwiftUI
import FirebaseAuth

class Authentication: ObservableObject {
    @Published var isValidated: Bool = false
    public var authRef = Auth.auth()
    
    init() {
        self.listen()
    }
    
    func listen() {
        self.authRef.addStateDidChangeListener { auth, user in
            if user != nil {
                self.updateValidation(success: true)
                
            } else {
                self.updateValidation(success: false)
            }
        }
    }
    
    func updateValidation(success: Bool) {
        withAnimation {
            self.isValidated = success
        }
    }
}
