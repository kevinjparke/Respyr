//
//  ChangeEmailView.swift
//  Respyr
//
//  Created by Kevin Parke on 1/15/22.
//

import SwiftUI

struct ChangeEmailView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State var email: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            FormTextFieldView(text: $email, placeholder: "E-Mail", icon: "textformat")
            
            Button(action: {
                self.userViewModel.email = self.email
                self.userViewModel.updateUserEmail(email: email)
                self.userViewModel.updateUser()
                
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
        .onAppear(perform: {
            self.email = userViewModel.email
        })
        .padding()
        .navigationTitle(Text("Update E-Mail Address"))
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
