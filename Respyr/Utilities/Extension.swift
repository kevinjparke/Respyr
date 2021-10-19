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
    
//    public func gradient1() -> some View {
//        self.overlay(LinearGradient(gradient: Gradient(colors: [Color.gradient1Color1, Color.gradient1Color2]), startPoint: .topLeading, endPoint: .bottomTrailing))
//            .mask(self)
//    }
}

extension Color {
    static public var themeBackground = Color("background")
    static public var gradient1Color1 = Color("gradient1ColorSet1")
    static public var gradient1Color2 = Color("gradient1ColorSet2")
    static public var textFieldBackground = Color("textFieldBackground")
    static public var themeRed = Color("themeRed")
//    static public var gradient2Color1 = Color("gradient2Color1")
//    static public var gradient2Color2 = Color("gradient2Color2")
}
