import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Ana Sayfa", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
            
            MaterialsView()
                .tabItem {
                    Label("Hammadde", systemImage: selectedTab == 1 ? "flask.fill" : "flask")
                }
                .tag(1)
            
            ColorantsView()
                .tabItem {
                    Label("Renk", systemImage: selectedTab == 2 ? "paintpalette.fill" : "paintpalette")
                }
                .tag(2)
            
            GlazeTypesView()
                .tabItem {
                    Label("Sır", systemImage: selectedTab == 3 ? "sparkles" : "sparkles")
                }
                .tag(3)
            
            SettingsView()
                .tabItem {
                    Label("Hakkında", systemImage: selectedTab == 4 ? "info.circle.fill" : "info.circle")
                }
                .tag(4)
        }
        .tint(.ceramicPrimary)
    }
}

#Preview {
    ContentView()
        .environmentObject(DataManager())
}
