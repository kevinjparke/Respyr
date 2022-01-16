//
//  BasicInformationView.swift
//  Respyr
//
//  Created by Kevin Parke on 10/14/21.
//

import SwiftUI
import CoreData
import FirebaseFirestore

struct BasicInformationView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                //Select profile picture button
                profilePicture
                
                //Full name form
                fullNameForm
                
                //User credentials
                userCredentialsForm
                
                Button(action: {
                    self.userViewModel.firstName = self.firstName
                    self.userViewModel.lastName = self.lastName
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
            .padding(.horizontal)
            .padding(.top, 40)
//            .preferredColorScheme(.dark)
        }
        .background(
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
        )
        .accentColor(Color.themeForeground)
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: self.$userViewModel.profileImage)
        }
        .navigationTitle(Text("Basic Information"))
        .onAppear {
            self.firstName = self.userViewModel.firstName
            self.lastName = self.userViewModel.lastName
        }
    }
    
    var profilePicture: some View {
        VStack(spacing: 4) {
            ProfilePictureView(profilePicture: self.userViewModel.profileImage)
                .onTapGesture {
                    self.showImagePicker.toggle()
                }
                .frame(height: 90)
            Text("Choose a photo")
                .font(.caption.bold())
        }
    }
    
    var fullNameForm: some View {
        VStack(spacing: 4) {
            Text("FULL NAME")
                .font(.caption.weight(.light))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                //First name textfield
                FormTextFieldView(text: $firstName, placeholder: "FirstName", icon: "textformat")
                
                //Last name textfield
                FormTextFieldView(text: $lastName, placeholder: "FirstName", icon: "textformat")
                
                //Instructor ID
                VStack(alignment: .leading, spacing: 4) {
                    HStack{
                        Text("*")
                            .foregroundColor(.red)
                        Text("Optional")
                            .opacity(0.5)
                    }
                    .font(.caption2)
                    FormTextFieldView(text: $userViewModel.instructorID, placeholder: "Instructor ID", icon: "lanyardcard.fill")
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(30)
            )
        }
    }
    
    var userCredentialsForm: some View {
        VStack(spacing: 4) {
            Text("USER CREDENTIALS")
                .font(.caption.weight(.light))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 16) {
                NavigationLink(destination: ChangeEmailView()) {
                    FormRowView(title: "Email", subtitle: "Edit your primary e-mail address")
                }
                
                NavigationLink(destination: ChangePasswordView()) {
                    FormRowView(title: "Password", subtitle: "Change your password", isLastIndex: true)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                    .background(Color.primary.opacity(0.1))
                    .cornerRadius(30)
            )
        }
    }
}

struct deprecated_SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BasicInformationView()
            .preferredColorScheme(.dark)
    }
}
