//
//  test_ProfileView.swift
//  Respyr
//
//  Created by Kevin Parke on 11/27/21.
//

import SwiftUI

struct ProfileView: View {
    @State private var universalSearch: String = ""
    @State private var selection: String = "home"
    @State private var showSetupView: Bool = false
    
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.presentationMode) var presentationMode
    
    
    
    private let gradient = Gradient(colors: [Color.gradient1Color1, Color.gradient1Color2])
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack(spacing: 8) {
                        Spacer()
                        NavigationLink(destination: Text("Edit View")) {
                            SecondaryButton2(iconName: "magnifyingglass")
                        }
                        
                        NavigationLink(destination: SettingsView()) {
                            SecondaryButton2(iconName: "slider.horizontal.3")
                        }
                    }
                    .padding(.horizontal)
                    .font(.system(size: 36))
                    .foregroundColor(.primary)
                    
                    VStack(spacing: 20) {
                                            
                        //Profile Header
                        VStack(spacing: 16) {
                            ProfilePictureView(profilePicture: self.userViewModel.profileImage)
                                .frame(height: 90)
                                .colorScheme(.light)
                                
                            
                            //Name and membership date
                            VStack(spacing: 4){
                                Text(self.getUserName())
                                    .font(.title).bold()
                                
                                Text("Member since: January, 2018")
                                    .font(.caption)
                                    .opacity(0.7)
                            }
                        }
                                            
                        VStack(spacing: 16) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Certificates")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Upload your official certificates")
                                    .font(.caption2.bold())
                                    .foregroundColor(.primary.opacity(0.7))
                            }
                            .padding(.horizontal)
                            
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    if userViewModel.certifications.isEmpty {
                                        CertificateCardView(isArrayEmpty: true)
                                    }
                                    ForEach(userViewModel.certifications, id: \.self) {cert in
                                        NavigationLink(destination: CertificationDetailView(certification: cert)) {
                                            CertificateCardView(certificate: cert)
                                                .frame(width: 280, alignment: .leading)
                                        }
                                    }
                                }
                                .padding([.bottom, .top],  32)
                                .padding([.leading, .trailing], 20)
                                .padding(.top, 16)

                            }
                                                
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Training Centers")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("Find a training center near you to start learning")
                                    .font(.caption2.bold())
                                    .foregroundColor(.primary.opacity(0.7))
                            }
                            .padding(.horizontal)
                                                
                            VStack {
//                                ForEach(test_trainingCenters.indices) { i in
//                                    if test_trainingCenters.first! {
//                                        TrainingCenterListRow(trainingCenter: test_trainingCenter[i], isFirstIndex: true, currentUserID: userViewModel.currentUserID)
//                                    }
//
//                                }
                                
                                
                                //Find training center button
                                NavigationLink(destination: FindTrainingCenterView()) {
                                    Text("Find training center")
                                        .font(.body).bold()
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                                .frame(height: 52)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.gradient1Color2, Color.gradient1Color1]), startPoint: .top, endPoint: .bottom))
                                .overlay(RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                                            .stroke(Color.white, lineWidth: 3)
                                            .blendMode(.overlay)
                                )
                                .cornerRadius(16.0)
                                .padding()
                                .shadow(color: Color.black.opacity(0.25), radius: 40, x: 0, y: 20)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                                    .background(Color.primary.opacity(0.1))
                                    .cornerRadius(30)
                            )
                            .padding()
                        }
                    }
                }
                .padding(.top, 60)
                .background(
                    Image(colorScheme == .dark ? "Background3" : "Background4")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                )
            }
            .background(Color.themeBackground.edgesIgnoringSafeArea(.all))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle(Text("Profile"))
            .fullScreenCover(isPresented: self.$userViewModel.showOnboardingView) {
                OnboardingScreen()
            }
        }
        .accentColor(Color.themeForeground)
    }
    
    private func getUserName() -> String {
        if userViewModel.firstName.isEmpty && userViewModel.lastName.isEmpty {
            return userViewModel.authRef.currentUser?.displayName ?? ""
        } else {
            return "\(userViewModel.firstName) \(userViewModel.lastName)"
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView()
                .preferredColorScheme(.dark)
            
            ProfileView()
//                    .preferredColorScheme(.dark)
        }
    }
}
