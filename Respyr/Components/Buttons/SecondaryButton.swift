//
//  SecondaryButton.swift
//  Respyr
//
//  Created by Kevin Parke on 11/2/21.
//

import SwiftUI

struct SecondaryButton: View {
    var text: String
    var action: ()->()
    
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.body).bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .frame(height: 52)
        .background(Color.gradient1Color1)
        .overlay(RoundedRectangle(cornerRadius: 16.0, style: .continuous)
                    .stroke(Color.white, lineWidth: 3)
                    .blendMode(.overlay)
        )
        .cornerRadius(16.0)
        .shadow(color: Color.black.opacity(0.25), radius: 40, x: 0, y: 20)
    }
}

//struct SecondaryButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SecondaryButton()
//    }
//}
