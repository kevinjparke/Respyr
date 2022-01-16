//
//  Extension.swift
//  Respyr
//
//  Created by Kevin Parke on 10/4/21.
//

import SwiftUI

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom))
            .mask(self)
    }
    
    public func glassBackground() -> some View {
        self.background(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.5), lineWidth: 1).blendMode(.overlay)
                    .background(Color.themeBackground.opacity(0.2))
                    .background(VisualEffectBlur(blurStyle: .systemThinMaterial))
                    .shadow(color: Color.black.opacity(0.2), radius: 60, x: 0, y: 30)
            )
            .cornerRadius(30)
    }
}

extension Color {
    static public var themeBackground = Color("background")
    static public var gradient1Color1 = Color("gradient1ColorSet1")
    static public var gradient1Color2 = Color("gradient1ColorSet2")
    static public var textFieldBackground = Color("textFieldBackground")
    static public var themeRed = Color("themeRed")
    static public var themeForeground = Color("foreground")
    static public var onboardingColor1 = Color("OnboardingColor1")
    static public var onboardingColor2 = Color("OnboardingColor2")
}
