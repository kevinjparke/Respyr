//
//  SignInWithAppleButton.swift
//  Respyr
//
//  Created by Kevin Parke on 10/7/21.
//

import SwiftUI
import AuthenticationServices

//Used whenever we want to merge SwiftUI with UIKit
struct SignInWithAppleButton: UIViewRepresentable {
    typealias UIViewType = ASAuthorizationAppleIDButton
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {}
}
