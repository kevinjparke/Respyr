//
//  SettingsView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/8/22.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    
    var body: some View {
        ZStack {
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                VStack {
                    NavigationLink(destination: BasicInformationView()) {
                        FormRowView(title: "Basic Information", subtitle: "Name, E-Mail, Profile Picture")
                    }
                    
                    
                    NavigationLink(destination: CertifictionListView()) {
                        FormRowView(title: "Certifications", subtitle: "ACLS, BLS, PALS, Heartsaver")
                    }
                    
                    FormRowView(title: "Privacy & Security", subtitle: "App Permissions, Terms of Service", isLastIndex: true)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(30)
                )
                
                Button(action: {
                    self.userViewModel.signOut()
                }) {
                    Text("Sign out")
                        .font(.body).bold()
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 52)
                .background(Color.gradient1Color1)
                .overlay(RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                            .stroke(Color.white, lineWidth: 3)
                            .blendMode(.overlay)
                )
                .cornerRadius(16.0)
                .shadow(color: Color.black.opacity(0.25), radius: 40, x: 0, y: 20)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(Text("Settings"))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
