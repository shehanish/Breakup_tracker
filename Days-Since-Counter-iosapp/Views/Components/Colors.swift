//
//  Colors.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//
import SwiftUI

// MARK: - Dynamic Color Helper
extension Color {
    init(light: Color, dark: Color) {
        self.init(UIColor { traits in
            return traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}

extension Color {
    static let lavender = Color(red: 189/255, green: 166/255, blue: 206/255)
    
    // MARK: - Brand Colors
    // A calm, deep slate in light mode / soft, airy ice-blue in dark mode
    static let brandPrimary = Color(
        light: Color(red: 44/255, green: 62/255, blue: 80/255),    // Deep Calm Slate
        dark: Color(red: 228/255, green: 233/255, blue: 242/255)   // Soft Ice Blue
    )
    
    // Automatically contrasts against brandPrimary
    static let textOnPrimary = Color(
        light: .white,
        dark: Color(red: 13/255, green: 14/255, blue: 19/255)      // Deep Background Color
    )
    
    // MARK: - App Background Gradient (Calm Slate & Midnight Sky)
    static let bgTop = Color(
        light: Color(red: 244/255, green: 246/255, blue: 249/255),
        dark: Color(red: 31/255, green: 35/255, blue: 45/255)
    )
    static let bgMiddle = Color(
        light: Color(red: 229/255, green: 233/255, blue: 240/255),
        dark: Color(red: 22/255, green: 25/255, blue: 33/255)
    )
    static let bgBottom = Color(
        light: Color(red: 208/255, green: 217/255, blue: 228/255),
        dark: Color(red: 13/255, green: 14/255, blue: 19/255)
    )
    
    static let appBackgroundGradient = LinearGradient(
        colors: [bgTop, bgMiddle, bgBottom],
        startPoint: .top,
        endPoint: .bottom
    )
}
