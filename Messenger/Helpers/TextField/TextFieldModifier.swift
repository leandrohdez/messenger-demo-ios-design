//
//  TextFieldModifier.swift
//  Messenger
//
//  Created by Leandro Hernandez on 11/3/22.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    let color: Color
    let padding: CGFloat // <- space between text and border
    let lineWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .background(color)
                    .frame(height: 48)
            )
    }
}

extension View {
    func customTextField(color: Color = .secondary, padding: CGFloat = 3, lineWidth: CGFloat = 1.0) -> some View { // <- Default settings
        self.modifier(TextFieldModifier(color: color, padding: padding, lineWidth: lineWidth))
    }
}
