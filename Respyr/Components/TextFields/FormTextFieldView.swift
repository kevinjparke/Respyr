//
//  FormTextFieldView.swift
//  Respyr
//
//  Created by Kevin Parke on 10/14/21.
//

import SwiftUI

struct FormTextFieldView: View {
    @Binding var text: String
    var placeholder: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
            
        }
        .padding(.horizontal)
        .frame(height: 52)
        .background(Color.textFieldBackground).cornerRadius(16.0)
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(lineWidth: 1)
                    .blendMode(.overlay)
        )
    }
}

struct FormTextFieldSecondary: View {
    @Binding var text: String
    var placeholder: String
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
            
            TextField(placeholder, text: $text)
                .autocapitalization(.none)
                .textContentType(.emailAddress)
            
        }
        .padding(.horizontal)
        .frame(height: 52)
        .background(Color.textFieldBackground).cornerRadius(16.0)
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(lineWidth: 1)
                    .blendMode(.overlay)
        )
    }
}
