////
////  ProfileView.swift
////  Respyr
////
////  Created by Kevin Parke on 10/6/21.
////
//
//import SwiftUI
//import CoreData
//import FirebaseAuth
//
//struct ProfileView: View {
//    //Environment variables
//    @EnvironmentObject var userViewModel: UserViewModel
//    @Environment(\.presentationMode) var presentationMode
//    
//    //Core Data
//    @State private var currentAccount: UserAccount?
//    
//    //View states
//    @State private var showSettingsView: Bool  = false
//    
//    var body: some View {
//        
//        NavigationView {
//            ZStack {
//                Color.themeBackground
//                    .edgesIgnoringSafeArea(.all)
//                
//                Image("Background3")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack(spacing: 20) {
//                    VStack(alignment: .leading, spacing: 16) {
//                        VStack(alignment: .leading, spacing: 16) {
//                            HStack(spacing: 16) {
//                                
//                                if userViewModel.profileImage != nil {
//                                    Image(uiImage: userViewModel.profileImage!)
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fill)
//                                        .frame(width: 52, height: 52, alignment: .center)
//                                        .clipShape(Circle())
//                                        .overlay(
//                                            Circle()
//                                                .stroke(Color.white, lineWidth: 3)
//                                                .blendMode(.overlay)
//                                        )
//                                } else {
//                                    Image(systemName: "person.circle.fill")
//                                        .font(.system(size: 52, weight: .medium))
//                                }
//                                
//                                VStack(alignment: .leading){
//                                    Text(userViewModel.fullName.count < 1 ? "No name" : userViewModel.fullName)
//                                        .font(.title2).bold()
//                                    
//                                    Text(userViewModel.userTitle)
//                                        .font(.footnote)
//                                        .opacity(0.7)
//                                        .lineLimit(2)
//                                }
//                                
//                                Spacer()
//                                
//                                Button(action: {
//                                    self.showSettingsView.toggle()
//                                }) {
//                                    Image(systemName: "gearshape.fill")
//                                        .font(.system(size: 25))
//                                        .foregroundColor(Color.primary)
//                                }
//                                .frame(maxHeight: 66, alignment: .top)
//                            }
//                        }
//                        
//                        SecondaryButton(text: "Sign out") {
//                            self.userViewModel.signOut()
//                            DispatchQueue.main.async {
//
//                                self.presentationMode.wrappedValue.dismiss()
//                            }
//                        }
//                        
//                    }
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 30, style: .continuous)
//                            .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
//                            .background(Color.themeBackground.opacity(0.2))
//                            .background(VisualEffectBlur(blurStyle: .systemThinMaterial))
//                            .shadow(color: Color.black.opacity(0.2), radius: 60, x: 0, y: 30)
//                    )
//                    .cornerRadius(30)
//                    
//                    VStack(alignment: .leading, spacing: 16) {
//                        Text("My Training Centers")
//                            .font(.title2).bold()
//                        
//                        //Find training center button
//                        NavigationLink(destination: FindTrainingCenterView()) {
//                            Text("Find training center")
//                                .font(.body).bold()
//                                .foregroundColor(.white)
//                                .frame(maxWidth: .infinity, alignment: .center)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .center)
//                        .frame(height: 52)
//                        .background(LinearGradient(gradient: Gradient(colors: [Color.gradient1Color2, Color.gradient1Color1]), startPoint: .top, endPoint: .bottom))
//                        .overlay(RoundedRectangle(cornerRadius: 16.0, style: .continuous)
//                                    .stroke(Color.white, lineWidth: 3)
//                                    .blendMode(.overlay)
//                        )
//                        .cornerRadius(16.0)
//                        .shadow(color: Color.black.opacity(0.25), radius: 40, x: 0, y: 20)
//                    }
//                    .padding()
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(
//                        RoundedRectangle(cornerRadius: 30, style: .continuous)
//                            .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
//                            .background(Color.themeBackground.opacity(0.5))
//                            .background(VisualEffectBlur(blurStyle: .systemThinMaterial))
//                            .shadow(color: Color.black.opacity(0.5), radius: 60, x: 0, y: 30)
//                    )
//                    .cornerRadius(30)
//                    
//                    Spacer()
//                    
//                }
//                .padding(.horizontal)
//                .padding(.top, 60)
//                .onAppear {
//                    userViewModel.test_fetchUser()
//                    userViewModel.test_fetchAllUsers()
//                }
//            }
//            .sheet(isPresented: $showSettingsView) {
//                SettingsView()
//        }
//        }
////        .preferredColorScheme(.dark)
//    }
//}
//
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
////            .preferredColorScheme(.dark)
//    }
//}
