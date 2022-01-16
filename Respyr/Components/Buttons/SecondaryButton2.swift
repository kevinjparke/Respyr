//
//  SecondaryButton2.swift
//  Respyr
//
//  Created by Kevin Parke on 12/20/21.
//

import SwiftUI

struct SecondaryButton2: View {
    var iconName: String
    var body: some View {
        ZStack{
            VisualEffectBlur(blurStyle: .systemThinMaterial)
                .frame(width: 44, height: 44, alignment: .center)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.7), lineWidth: 2)
                        .blendMode(.overlay)
                )
            
            Image(systemName: iconName)
                .font(.system(size: 24))
        }
    }
}

struct SecondaryButton2_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton2(iconName: "magnifyingglass")
//            .preferredColorScheme(.dark)
    }
}
