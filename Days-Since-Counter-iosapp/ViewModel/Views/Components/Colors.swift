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
    // MARK: - Calm & Grounding Palette (Sage & Sand)
    static let darkCharcoal = Color(red: 44/255, green: 56/255, blue: 50/255)
    static let mutedForest  = Color(red: 28/255, green: 35/255, blue: 31/255)
    static let sageGreen    = Color(red: 141/255, green: 163/255, blue: 153/255)
    static let softSand     = Color(red: 249/255, green: 249/255, blue: 245/255)
    static let warmGray     = Color(red: 235/255, green: 236/255, blue: 232/255)
    
    // MARK: - Brand Colors
    // A soothing sage green fits the "healing/calm" theme perfectly
    static let brandPrimary = darkCharcoal
    
    // Auto-contrasts against the background (Dark Charcoal in Light mode, Soft Sand in Dark mode)
    static let textOnPrimary = Color(
        light: darkCharcoal,
        dark: darkCharcoal
    )
    
    // Button Text Color (White/Sand for inside Sage buttons)
    static let buttonText = softSand
    
    // MARK: - App Background Gradient
    // Light Mode: Very soft, warm off-white merging into a very light warm-gray
    // Dark Mode: Muted forest tones, deep and grounded without being harshly black
    static let bgTop = Color(
        light: Color(red: 252/255, green: 252/255, blue: 250/255),
        dark: sageGreen
    )
    static let bgMiddle = Color(
        light: Color(red: 247/255, green: 248/255, blue: 245/255),
        dark: sageGreen
    )
    static let bgBottom = Color(
        light: Color(red: 230/255, green: 232/255, blue: 228/255),
        dark: sageGreen
    )
    
    static let appBackgroundGradient = LinearGradient(
        colors: [bgTop, bgMiddle, bgBottom],
        startPoint: .top,
        endPoint: .bottom
    )
}
