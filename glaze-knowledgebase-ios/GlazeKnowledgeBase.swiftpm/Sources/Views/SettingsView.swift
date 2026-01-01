import SwiftUI

struct SettingsView: View {
    @AppStorage("themeMode") private var themeMode: ThemeMode = .system
    @State private var showThemeSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Ayarlar")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Theme Setting
                VStack(spacing: 0) {
                    Button(action: { showThemeSheet = true }) {
                        HStack {
                            Image(systemName: "paintpalette")
                                .foregroundColor(.ceramicPrimary)
                                .frame(width: 30)
                            
                            VStack(alignment: .leading) {
                                Text("Tema")
                                    .foregroundColor(.primary)
                                Text(themeMode.rawValue)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                        .padding()
                    }
                }
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                
                // About Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Hakkında")
                        .font(.headline)
                    
                    Text("Seramik Bilgi Bankası.")
                        .font(.subheadline)
                    
                    Text("Formül veya reçete içermez.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Divider()
                    
                    HStack {
                        Text("Sürüm")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("1.0.0")
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Geliştirici")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("Pia Ceramic")
                            .font(.caption)
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showThemeSheet) {
            ThemeSelectionSheet(themeMode: $themeMode, isPresented: $showThemeSheet)
                .presentationDetents([.height(250)])
        }
    }
}

struct ThemeSelectionSheet: View {
    @Binding var themeMode: ThemeMode
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ThemeMode.allCases, id: \.self) { mode in
                    Button(action: {
                        themeMode = mode
                        isPresented = false
                    }) {
                        HStack {
                            Text(mode.rawValue)
                                .foregroundColor(.primary)
                            Spacer()
                            if themeMode == mode {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.ceramicPrimary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Tema")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("İptal") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
