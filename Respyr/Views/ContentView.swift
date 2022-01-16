//
//  ContentView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/6/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    var body: some View {
        Group {
            if sessionStore.isSignedIn {
                ProfileView()
            } else {
                SignupView()
            }
        }
    }
}
