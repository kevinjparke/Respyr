//
//  SignupView.swift
//  Respyr
//
//  Created by Kevin Parke on 9/30/21.
//

import SwiftUI
import CoreData

struct SignupView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var coreDataViewModel: CoreDataViewModel
    
    @State private var signupToggle: Bool = true
    @State private var showProfileToggle: Bool  = false
    @State private var showAlertView: Bool = false
    
    @State private var rotationAngle = 0.0
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            
            //Background here
            
            Image(colorScheme == .light ? "Background1" : "Background2")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack(alignment:.leading, spacing: 16.0) {
                    Text(signupToggle ? "Sign up" : "Sign in")
                        .font(.largeTitle.bold())
                    Text("Learn critical life support skills at a training center near you.")
                        .font(.subheadline).opacity(0.7)
                    
                    //Email textfield
                    TextFieldView(text: $userViewModel.email, icon: "envelope.open.fill", placeholder: "Email")
                    
                    //Password textfield
                    TextFieldView(text: $userViewModel.password, icon: "key.fill", placeholder: "Password", isSecureTextField: true)
                    
                    //Sign up
                    MainGradientButtonView(text: signupToggle ? "Sign up" : "Sign in") {
                        signupToggle ? userViewModel.signUp() : userViewModel.signIn()
                    }
                    .onAppear {
                        userViewModel.authRef.addStateDidChangeListener { auth, user in
                            if let currentUser = user {
                                if coreDataViewModel.savedUserEntity.count == 0 {
                                    //Add data to core data
                                    let userDataToSave = User(userID: currentUser.uid, fullName: currentUser.displayName ?? "",  email: currentUser.email ?? "")
                                    //Save user to core data
                                    coreDataViewModel.addUser(user: userDataToSave)
                                    DispatchQueue.main.async {
                                        self.showProfileToggle.toggle()
                                    }
                                }
                                self.showProfileToggle.toggle()
                            }
                        }
                    }
                    
                    Rectangle()
                        .frame(height: 1).opacity(0.1)
                    
                    if signupToggle {
                        Text("By signing up, you agree to our Terms of Service and Privacy Policy.")
                            .font(.footnote)
                            .opacity(0.7)
                    } else {
                        Button(action: {
                            self.userViewModel.sendPasswordResetEmail()
                        }){
                            HStack(spacing: 4){
                                Text("Forgot your password?")
                                    .font(.footnote)
                                    .foregroundColor(.primary)
                                
                                Text("Reset password")
                                    .font(.footnote.bold())
                                    .gradientForeground(colors: [.gradient1Color1, .gradient1Color2])
                                    .colorScheme(colorScheme == .light ? .dark : .light)
                            }
                        }
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 16){
                        Button(action:{
                            withAnimation {
                                self.signupToggle.toggle()
                                self.rotationAngle += 180
                            }
                        }){
                            HStack(spacing: 4){
                                Text(signupToggle ? "Already have an account?" : "Don't have an account?")
                                    .font(.footnote)
                                    .foregroundColor(.primary)
                                
                                Text(signupToggle ? "Sign in" : "Create account")
                                    .font(.footnote.bold())
                                    .gradientForeground(colors: [.gradient1Color1, .gradient1Color2])
                                    .colorScheme(colorScheme == .light ? .dark : .light)
                            }
                        }
                    }
                    
                    
                    if !signupToggle {
                        Rectangle()
                            .frame(height: 1)
                            .opacity(0.1)
                        
                        Button(action: {print("Sign in with Apple is disabled.")}) {
                            SignInWithAppleButton()
                                .frame(height: 50)
                                .cornerRadius(16)
                        }
                    }
                }
                .padding(20)
            }
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
            .background(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                    .background(Color.themeBackground.opacity(0.5))
                    .background(VisualEffectBlur(blurStyle: .systemThinMaterial))
                    .shadow(color: Color.black.opacity(0.5), radius: 60, x: 0, y: 30)
            )
            .fullScreenCover(isPresented: $showProfileToggle) {
                ProfileView()
            }
            .alert(isPresented: $userViewModel.alertToggle) {
                Alert(title: Text(userViewModel.alertTitle), message: Text(userViewModel.alertMessage), dismissButton: .cancel())
            }
            .cornerRadius(30)
            .padding(.horizontal)
            .rotation3DEffect(
                Angle(degrees: self.rotationAngle),
                axis: (x: 0.0, y: 1.0, z: 0.0)
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .preferredColorScheme(.dark)
    }
}
