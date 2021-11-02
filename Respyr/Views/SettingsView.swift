//
//  SettingsView.swift
//  Respyr
//
//  Created by Kevin Parke on 10/14/21.
//

import SwiftUI
import CoreData
import FirebaseFirestore

struct SettingsView: View {
    @State private var fullName: String  = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var instructorID: String = ""
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        ZStack {
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 16) {
                //Select profile picture button
                Button(action: {
                    self.showImagePicker.toggle()
                }, label: {
                    VStack(spacing: 12) {
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 1)
                                .blendMode(.overlay)
                            if userViewModel.profileImage != nil {
                                Image(uiImage: userViewModel.profileImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 66, height: 66, alignment: .center)
                                    .cornerRadius(8)
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 66, weight: .medium))
                            }
                        }
                        .frame(width: 66, height:66)
//                            .padding([.vertical, .leading], 8)
                        
                        Text("Choose a photo")
                    }
                })
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.primary)
                    
                
                //First name
                FormTextFieldView(text: $userViewModel.fullName, placeholder: "Full name", icon: "textformat")
                
                //Email
                FormTextFieldView(text: $userViewModel.email, placeholder: "Email", icon: "envelope.open.fill")
                
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
                
                Button(action: {print("Save profile settings")}) {
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
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: self.$userViewModel.profileImage)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
