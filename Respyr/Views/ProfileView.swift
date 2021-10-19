//
//  ProfileView.swift
//  Respyr
//
//  Created by Kevin Parke on 10/6/21.
//

import SwiftUI
import CoreData
import FirebaseAuth

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \UserAccount.memberSince, ascending: true)], predicate: NSPredicate(format: "userID == %@", Auth.auth().currentUser!.uid), animation: .default) private var savedAccounts: FetchedResults<UserAccount>
    @State private var currentAccount: UserAccount?
    
    @State private var showSettingsView: Bool  = false
    
    var body: some View {
        
        ZStack {
            Image("Background3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack(spacing: 16) {
                            
                            if userViewModel.profileImage != nil {
                                Image(uiImage: userViewModel.profileImage!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 52, height: 52, alignment: .center)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle()
                                            .stroke(Color.white, lineWidth: 3)
                                            .blendMode(.overlay)
                                    )
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 52, weight: .medium))
                            }
                            
                            VStack(alignment: .leading){
                                Text(userViewModel.fullName.count < 1 ? "No name" : userViewModel.fullName)
                                    .font(.title2).bold()
                                
                                Text(userViewModel.userTitle)
                                    .font(.footnote)
                                    .opacity(0.7)
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                self.showSettingsView.toggle()
                            }) {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 25))
                                    .foregroundColor(Color.primary)
                            }
                            .frame(maxHeight: 66, alignment: .top)
                        }
                    }
                    
                    Button(action: {
                        self.userViewModel.signOut()
                        DispatchQueue.main.async {

                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Sign out")
                            .font(.body).bold()
                            .gradientForeground(colors: [.gradient1Color1, .gradient1Color2])
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(Color.primary)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke()
                    )
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                        .background(Color.themeBackground.opacity(0.5))
                        .background(VisualEffectBlur(blurStyle: .systemThinMaterial))
                        .shadow(color: Color.black.opacity(0.5), radius: 60, x: 0, y: 30)
                )
                .cornerRadius(30)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("My Training Centers")
                        .font(.title2).bold()
                    
                    TrainingCenterListRow()
                    TrainingCenterListRow()
                    TrainingCenterListRow()
                    TrainingCenterListRow()
                    TrainingCenterListRow()
                    
                    //Find training center button
                    MainGradientButtonView(text: "Find a training center") {
                        print("Segue to find training center view")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                        .background(Color.themeBackground.opacity(0.5))
                        .background(VisualEffectBlur(blurStyle: .systemThinMaterial))
                        .shadow(color: Color.black.opacity(0.5), radius: 60, x: 0, y: 30)
                )
                .cornerRadius(30)
                
            }
            .padding(.horizontal)
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .preferredColorScheme(.dark)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
//            .preferredColorScheme(.dark)
    }
}
