//
//  OnboardingScreen.swift
//  Respyr
//
//  Created by Kevin Parke on 1/1/22.
//

import SwiftUI

struct OnboardingScreen: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            
            //This view should first present a few slides introducing the user to the app. as well as showing the user how the app works. The plan is to get live screenshots to present to the user when they first sign in.
            
            ZStack {
                LinearGradient(colors: [Color.onboardingColor1, Color.onboardingColor2], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Hello!")
                            .font(.largeTitle.bold())
                            
                        Text("We need to know who you are in order to get you started. Type in your name as you would like it on an official certificate.")
                            .font(.footnote)
                            .opacity(0.7)
                    }
                    .foregroundColor(.white)
                    
                    
                    //There are currently no APIs to change the color of the placeholder
                    TextField("First Name", text: $userViewModel.firstName)
                        .autocapitalization(.sentences)
                        .textContentType(.name)
                        .foregroundColor(.white)
                        .colorScheme(.dark)
                        .padding()
                        .frame(height: 52)
                        .background(Color.secondary.opacity(0.4)).cornerRadius(16.0)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 1)
                                    .blendMode(.overlay)
                    )
                    
                    TextField("Last Name", text: $userViewModel.lastName)
                        .autocapitalization(.sentences)
                        .textContentType(.name)
                        .foregroundColor(.white)
                        .colorScheme(.dark)
                        .padding()
                        .frame(height: 52)
                        .background(Color.secondary.opacity(0.4)).cornerRadius(16.0)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.white, lineWidth: 1)
                                    .blendMode(.overlay)
                    )
                    
                    NavigationLink(destination: OnboardingCertView()) {
                        Text("Next")
                            .foregroundColor(Color.white)
                            .font(.headline)
                    }
                    .disabled(!self.userViewModel.isSignupComplete())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(height: 52)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.gradient1Color2, Color.gradient1Color1]), startPoint: .top, endPoint: .bottom))
                    .overlay(RoundedRectangle(cornerRadius: 16.0)
                                .stroke(Color.white, lineWidth: 3)
                                .blendMode(.overlay)
                    )
                    .cornerRadius(16.0)
                    .shadow(color: Color.black.opacity(0.25), radius: 40, x: 0, y: 20)
                    
                    Spacer()
                    
                }
                .onAppear(perform: {
                    if self.userViewModel.dismissOnboardingScreen {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                })
                .padding(20)
            }
            .colorScheme(.dark)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}
