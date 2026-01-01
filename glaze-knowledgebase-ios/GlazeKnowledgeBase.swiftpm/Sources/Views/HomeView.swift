import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let destination: HomeDestination
}

enum HomeDestination: Hashable {
    case materials
    case colorants
    case recipes
    case glazeTypes
    case firing
    case surfaceEffects
    case safety
    case glossary
    case settings
}

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var navigationPath = NavigationPath()
    
    let menuItems: [MenuItem] = [
        MenuItem(title: "Hammaddeler", subtitle: "Eriticiler, cam oluşturucular", icon: "flask", destination: .materials),
        MenuItem(title: "Renk Vericiler", subtitle: "Oksitler ve pigmentler", icon: "paintpalette", destination: .colorants),
        MenuItem(title: "Sır Reçeteleri", subtitle: "Reçeteler ve hesaplayıcı", icon: "doc.text", destination: .recipes),
        MenuItem(title: "Sır Tipleri", subtitle: "Mat, parlak, saten", icon: "sparkles", destination: .glazeTypes),
        MenuItem(title: "Pişirim", subtitle: "Sıcaklık ve atmosfer", icon: "flame", destination: .firing),
        MenuItem(title: "Yüzey Efektleri", subtitle: "Kristal, crawling", icon: "square.stack.3d.up", destination: .surfaceEffects),
        MenuItem(title: "Güvenlik", subtitle: "Malzeme güvenliği", icon: "cross.case", destination: .safety),
        MenuItem(title: "Sözlük", subtitle: "Seramik terimleri", icon: "book", destination: .glossary),
        MenuItem(title: "Hakkında", subtitle: "Uygulama bilgileri", icon: "info.circle", destination: .settings)
    ]
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Group {
                if dataManager.isLoading {
                    LoadingView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            // Header
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Seramik Bilgi Bankası")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .fontDesign(.serif)
                                
                                Text("Hammaddeler, Sır Türleri, Renk Vericiler, Pişirim Türleri Hakkında Pratik Bilgiler")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal)
                            
                            // Grid of cards
                            LazyVGrid(columns: columns, spacing: 12) {
                                ForEach(menuItems) { item in
                                    MenuCard(item: item) {
                                        navigationPath.append(item.destination)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            // Disclaimer
                            Text("Sorumluluk Beyanı: Bu uygulama bilgilendirme amaçlıdır. Kimyasal kullanımında yerel güvenlik talimatlarına uyunuz. Geliştirici, bu bilgilerin kullanımından doğabilecek sonuçlardan sorumlu tutulamaz.")
                                .font(.caption2)
                                .foregroundColor(.secondary.opacity(0.6))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .padding(.vertical)
                        }
                    }
                }
            }
            .navigationDestination(for: HomeDestination.self) { destination in
                destinationView(for: destination)
            }
            .navigationDestination(for: MaterialDetailNavigation.self) { nav in
                MaterialDetailView(material: nav.material)
            }
            .navigationDestination(for: ColorantDetailNavigation.self) { nav in
                ColorantDetailView(colorant: nav.colorant)
            }
            .navigationDestination(for: GlazeTypeDetailNavigation.self) { nav in
                GlazeTypeDetailView(glazeType: nav.glazeType)
            }
            .navigationDestination(for: FiringTypeDetailNavigation.self) { nav in
                FiringTypeDetailView(firingType: nav.firingType)
            }
            .navigationDestination(for: SurfaceEffectDetailNavigation.self) { nav in
                SurfaceEffectDetailView(surfaceEffect: nav.surfaceEffect)
            }
            .navigationDestination(for: SafetyInfoDetailNavigation.self) { nav in
                SafetyInfoDetailView(safetyInfo: nav.safetyInfo)
            }
            .navigationDestination(for: GlossaryTermDetailNavigation.self) { nav in
                GlossaryTermDetailView(glossaryTerm: nav.glossaryTerm)
            }
            .navigationDestination(for: RecipeDetailNavigation.self) { nav in
                RecipeDetailView(recipe: nav.recipe)
            }
        }
    }
    
    @ViewBuilder
    func destinationView(for destination: HomeDestination) -> some View {
        switch destination {
        case .materials: MaterialsView()
        case .colorants: ColorantsView()
        case .recipes: RecipesView()
        case .glazeTypes: GlazeTypesView()
        case .firing: FiringTypesView()
        case .surfaceEffects: SurfaceEffectsView()
        case .safety: SafetyInfoView()
        case .glossary: GlossaryView()
        case .settings: SettingsView()
        }
    }
}

// MARK: - Navigation Types
struct MaterialDetailNavigation: Hashable {
    let material: Material
}

struct ColorantDetailNavigation: Hashable {
    let colorant: Colorant
}

struct GlazeTypeDetailNavigation: Hashable {
    let glazeType: GlazeType
}

struct FiringTypeDetailNavigation: Hashable {
    let firingType: FiringType
}

struct SurfaceEffectDetailNavigation: Hashable {
    let surfaceEffect: SurfaceEffect
}

struct SafetyInfoDetailNavigation: Hashable {
    let safetyInfo: SafetyInfo
}

struct GlossaryTermDetailNavigation: Hashable {
    let glossaryTerm: GlossaryTerm
}

struct RecipeDetailNavigation: Hashable {
    let recipe: Recipe
}

// MARK: - Menu Card
struct MenuCard: View {
    let item: MenuItem
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: item.icon)
                    .font(.system(size: 28))
                    .foregroundColor(.ceramicPrimary)
                
                Text(item.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                Text(item.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .aspectRatio(1.1, contentMode: .fit)
            .background(Color(.systemGray6).opacity(0.5))
            .cornerRadius(24)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HomeView()
        .environmentObject(DataManager())
}
