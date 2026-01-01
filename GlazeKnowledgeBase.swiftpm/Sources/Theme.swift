import SwiftUI

// MARK: - App Colors
extension Color {
    // Primary earth tones for ceramics
    static let ceramicPrimary = Color(red: 139/255, green: 90/255, blue: 43/255)
    static let ceramicPrimaryLight = Color(red: 255/255, green: 183/255, blue: 124/255)
    static let ceramicPrimaryContainer = Color(red: 255/255, green: 220/255, blue: 194/255)
    static let ceramicSecondary = Color(red: 117/255, green: 88/255, blue: 72/255)
    
    // Safety colors
    static let safetyToxic = Color(red: 211/255, green: 47/255, blue: 47/255)
    static let safetyCaution = Color(red: 255/255, green: 160/255, blue: 0/255)
    static let safetySafe = Color(red: 56/255, green: 142/255, blue: 60/255)
    
    // Background colors
    static let lightBackground = Color(red: 255/255, green: 251/255, blue: 255/255)
    static let darkBackground = Color(red: 32/255, green: 26/255, blue: 23/255)
}

// MARK: - Theme Environment
struct AppTheme {
    let primary: Color
    let onPrimary: Color
    let primaryContainer: Color
    let onPrimaryContainer: Color
    let secondary: Color
    let background: Color
    let surface: Color
    let surfaceVariant: Color
    let onSurface: Color
    let onSurfaceVariant: Color
    
    static let light = AppTheme(
        primary: .ceramicPrimary,
        onPrimary: .white,
        primaryContainer: .ceramicPrimaryContainer,
        onPrimaryContainer: Color(red: 46/255, green: 21/255, blue: 0/255),
        secondary: .ceramicSecondary,
        background: .lightBackground,
        surface: .lightBackground,
        surfaceVariant: Color(red: 240/255, green: 232/255, blue: 228/255),
        onSurface: .black,
        onSurfaceVariant: Color(red: 80/255, green: 70/255, blue: 65/255)
    )
    
    static let dark = AppTheme(
        primary: .ceramicPrimaryLight,
        onPrimary: Color(red: 74/255, green: 40/255, blue: 0/255),
        primaryContainer: Color(red: 106/255, green: 60/255, blue: 0/255),
        onPrimaryContainer: .ceramicPrimaryContainer,
        secondary: Color(red: 230/255, green: 190/255, blue: 171/255),
        background: .darkBackground,
        surface: .darkBackground,
        surfaceVariant: Color(red: 60/255, green: 50/255, blue: 45/255),
        onSurface: .white,
        onSurfaceVariant: Color(red: 180/255, green: 170/255, blue: 165/255)
    )
}
