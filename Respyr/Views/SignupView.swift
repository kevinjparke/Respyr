////
////  SignupView.swift
////  Respyr
////
////  Created by Kevin Parke on 10/1/21.
////
//
//import Foundation
//import SwiftUI
//
//struct SignupView: View {
//    @StateObject private var userViewModel = UserViewModel()
//    @State private var showProfileView: Bool = false
//    @State private var toggleSignup: Bool = true
//    
//    var body: some View {
//        ZStack {
//            VStack{
//                VStack(alignment: .leading, spacing: 16) {
//                    Text(toggleSignup ? "Sign up" : "Sign in")
//                        .font(.largeTitle).bold()
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    Text("Find a training center near you and begin learning crucial life support skills.")
//                        .font(.caption).opacity(0.7)
//                    
//                
//                }
//                .padding(.horizontal)
//                
//                TextField("Email", text: $userViewModel.email)
//                    .padding(.horizontal)
//                TextField("Password", text: $userViewModel.password)
//                    .padding(.horizontal)
//                
//                Button(action: {
//                    if toggleSignup == false {
//                        self.userViewModel.signIn()
//                    } else {
//                        userViewModel.signUp()
//                    }
//                }) {
//                    Text(toggleSignup ? "Sign up" : "Sign in")
//                }
//                
//                Button(action:{
//                    self.toggleSignup.toggle()
//                }) {
//                    HStack {
//                        Text("Already have an account?")
//                        Text("Sign in")
//                    }
//                }
//                
//            }
//            .onAppear(perform: {
//                self.showProfileView = userViewModel.userAuth.isSignedIn
//            })
//            .background(Color.gray)
//            .padding()
//        }
//        .fullScreenCover(isPresented: $showProfileView){
//            ProfileView()
//        }
//    }
//}
//
//struct SignupView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignupView()
//    }
//}
