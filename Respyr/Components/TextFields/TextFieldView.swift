//
//  TextFieldView.swift
//  Respyr
//
//  Created by Kevin Parke on 10/4/21.
//

import SwiftUI

struct TextFieldView: View {
    @Binding var text: String
    var icon: String
    var placeholder: String
    var isSecureTextField: Bool = false
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            
            if isSecureTextField {
                SecureField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .textContentType(.password)
            } else {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .textContentType(.emailAddress)
            }
            
        }
        .padding(.horizontal)
        .frame(height: 52)
        .background(Color.themeBackground).cornerRadius(16.0)
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(lineWidth: 1)
                    .blendMode(.overlay)
        )
    }
}
