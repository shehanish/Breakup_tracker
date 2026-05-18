//
//  Colors.swift
//  Days-Since-Counter-iosapp
//
//  Created by Shehani Hansika on 07.05.26.
//
import SwiftUI

extension Color {
    static let lavender = Color(red: 189/255, green: 166/255, blue: 206/255)
    /// rgb(62, 30, 104)
    static let brandPrimary = Color(red: 62/255, green: 30/255, blue: 104/255)
    
    // MARK: - App Background Gradient
    static let bgTop = Color(red: 0.98, green: 0.88, blue: 0.94)
    static let bgMiddle = Color(red: 0.92, green: 0.85, blue: 0.97)
    static let bgBottom = Color(red: 0.88, green: 0.82, blue: 0.96)
    
    static let appBackgroundGradient = LinearGradient(
        colors: [bgTop, bgMiddle, bgBottom],
        startPoint: .top,
        endPoint: .bottom
    )
}
