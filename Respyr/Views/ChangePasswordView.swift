//
//  ChangePasswordView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/15/22.
//

import SwiftUI

struct ChangePasswordView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var oldPassword: String = ""
    @State private var newPassword: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            TextFieldView(text: $oldPassword, icon: "key.fill", placeholder: "Old Password", isSecureTextField: true)
            
            TextFieldView(text: $newPassword, icon: "key.fill", placeholder: "New Password", isSecureTextField: true)
            
            Button(action: {
                self.userViewModel.reauthenticateUser(oldPassword: oldPassword, newPassword: newPassword)
                
            }) {
                Text("Save")
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
        .alert(isPresented: $userViewModel.alertToggle) {
            Alert(title: Text(userViewModel.alertTitle), message: Text(userViewModel.alertMessage), dismissButton: .default(Text("Okay")))
        }
        .padding()
        .navigationTitle(Text("Change Password"))
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
