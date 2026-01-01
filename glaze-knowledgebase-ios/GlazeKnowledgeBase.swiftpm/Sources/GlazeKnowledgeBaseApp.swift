import SwiftUI

@main
struct GlazeKnowledgeBaseApp: App {
    @StateObject private var dataManager = DataManager()
    @AppStorage("themeMode") private var themeMode: ThemeMode = .system
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataManager)
                .preferredColorScheme(colorScheme)
        }
    }
    
    private var colorScheme: ColorScheme? {
        switch themeMode {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
