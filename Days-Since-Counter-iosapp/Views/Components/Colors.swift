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
    // MARK: - Base Palette (From Image)
    static let midnight   = Color(red: 11/255, green: 25/255, blue: 87/255)     // #0b1957
    static let sapphire   = Color(red: 66/255, green: 107/255, blue: 194/255)   // #426bc2
    static let petal      = Color(red: 232/255, green: 217/255, blue: 237/255)  // #e8d9ed
    static let lace       = Color(red: 247/255, green: 244/255, blue: 237/255)  // #f7f4ed
    static let lavender   = Color(red: 210/255, green: 179/255, blue: 219/255)  // #d2b3db
    static let bridalBlue = Color(red: 233/255, green: 243/255, blue: 255/255)  // #e9f3ff
    
    // MARK: - Brand Colors
    // Force Sapphire for UI elements
    static let brandPrimary = sapphire
    
    // Force Petal for texts on primary
    static let textOnPrimary = petal
    
    // MARK: - App Background Gradient
    // Forced Midnight background across the entire app
    static let bgTop = midnight
    static let bgMiddle = midnight
    static let bgBottom = midnight
    
    static let appBackgroundGradient = LinearGradient(
        colors: [bgTop, bgMiddle, bgBottom],
        startPoint: .top,
        endPoint: .bottom
    )
}
