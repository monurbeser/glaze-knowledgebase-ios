import SwiftUI

struct SurfaceEffectsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchQuery = ""
    
    var filteredEffects: [SurfaceEffect] {
        dataManager.searchSurfaceEffects(query: searchQuery)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Yüzey Efektleri")
                    .font(.title)
                    .fontWeight(.bold)
                
                SearchBar(text: $searchQuery)
            }
            .padding()
            
            // List
            if dataManager.isLoading {
                Spacer()
                LoadingView()
                Spacer()
            } else if filteredEffects.isEmpty {
                Spacer()
                EmptyStateView()
                Spacer()
            } else {
                List(filteredEffects) { effect in
                    NavigationLink(value: SurfaceEffectDetailNavigation(surfaceEffect: effect)) {
                        SurfaceEffectRow(effect: effect)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Yüzey Efektleri")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SurfaceEffectRow: View {
    let effect: SurfaceEffect
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(effect.name)
                .font(.headline)
            
            InfoChip(text: effect.effectType.displayName)
            
            Text(effect.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - SurfaceEffect Detail View
struct SurfaceEffectDetailView: View {
    let surfaceEffect: SurfaceEffect
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Effect Type
                InfoChip(text: surfaceEffect.effectType.displayName)
                
                // Description
                Text(surfaceEffect.description)
                    .font(.body)
                
                // Visual Appearance
                SectionTitle(title: "Görünüm")
                Text(surfaceEffect.visualAppearance)
                    .font(.subheadline)
                
                // Causes
                if !surfaceEffect.causes.isEmpty {
                    SectionTitle(title: "Nedenler")
                    ForEach(surfaceEffect.causes, id: \.self) { cause in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(cause)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Associated Factors
                if !surfaceEffect.associatedFactors.isEmpty {
                    SectionTitle(title: "İlgili Faktörler")
                    ForEach(surfaceEffect.associatedFactors, id: \.self) { factor in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(factor)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Historical Context
                SectionTitle(title: "Tarih")
                Text(surfaceEffect.historicalContext)
                    .font(.subheadline)
                
                // Notable Examples
                if !surfaceEffect.notableExamples.isEmpty {
                    SectionTitle(title: "Öne Çıkan Örnekler")
                    ForEach(surfaceEffect.notableExamples, id: \.self) { example in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(example)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Attribution
                AttributionCard(wikipediaTitle: surfaceEffect.attribution.wikipediaTitle)
            }
            .padding()
        }
        .navigationTitle(surfaceEffect.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SurfaceEffectsView()
            .environmentObject(DataManager())
    }
}
