//
//  MainButton.swift
//  Respyr
//
//  Created by Kevin Parke on 10/7/21.
//

import SwiftUI

struct MainGradientButtonView: View {
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.body).bold()
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 52)
        .background(LinearGradient(gradient: Gradient(colors: [Color.gradient1Color2, Color.gradient1Color1]), startPoint: .top, endPoint: .bottom))
        .overlay(RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                    .stroke(Color.white, lineWidth: 3)
                    .blendMode(.overlay)
        )
        .cornerRadius(16.0)
        .shadow(color: Color.black.opacity(0.25), radius: 40, x: 0, y: 20)
    }
}
