import SwiftUI

struct ColorantsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchQuery = ""
    
    var filteredColorants: [Colorant] {
        dataManager.searchColorants(query: searchQuery)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Renk Vericiler")
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
            } else if filteredColorants.isEmpty {
                Spacer()
                EmptyStateView()
                Spacer()
            } else {
                List(filteredColorants) { colorant in
                    NavigationLink(value: ColorantDetailNavigation(colorant: colorant)) {
                        ColorantRow(colorant: colorant)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ColorantRow: View {
    let colorant: Colorant
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(colorant.name)
                    .font(.headline)
                Spacer()
                SafetyBadge(safetyLevel: colorant.safetyLevel)
            }
            
            HStack(spacing: 8) {
                InfoChip(text: colorant.colorFamily.displayName)
                Text(colorant.chemicalName)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(colorant.description)
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

// MARK: - Colorant Detail View
struct ColorantDetailView: View {
    let colorant: Colorant
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header badges
                HStack(spacing: 8) {
                    InfoChip(text: colorant.colorFamily.displayName)
                    SafetyBadge(safetyLevel: colorant.safetyLevel)
                }
                
                // Chemical name
                Text(colorant.chemicalName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Description
                Text(colorant.description)
                    .font(.body)
                
                // Atmosphere Effects
                SectionTitle(title: "Atmosfer")
                VStack(alignment: .leading, spacing: 4) {
                    Text("Oksidasyon: \(colorant.atmosphereEffects.oxidation)")
                    Text("Redüksiyon: \(colorant.atmosphereEffects.reduction)")
                }
                .font(.subheadline)
                
                // Color Characteristics
                if !colorant.colorCharacteristics.isEmpty {
                    SectionTitle(title: "Renk Özellikleri")
                    ForEach(colorant.colorCharacteristics, id: \.self) { char in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(char)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Temperature Sensitivity
                SectionTitle(title: "Sıcaklık Hassasiyeti")
                Text(colorant.temperatureSensitivity)
                    .font(.subheadline)
                
                // Historical Background
                SectionTitle(title: "Tarih")
                Text(colorant.historicalBackground)
                    .font(.subheadline)
                
                // Safety
                SectionTitle(title: "Güvenlik")
                Text(colorant.safetyNotes)
                    .font(.subheadline)
                
                // Related Colorants
                if !colorant.relatedColorantIds.isEmpty {
                    let relatedColorants = dataManager.getColorants(ids: colorant.relatedColorantIds)
                    if !relatedColorants.isEmpty {
                        SectionTitle(title: "İlgili Renk Vericiler")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(relatedColorants) { related in
                                    NavigationLink(value: ColorantDetailNavigation(colorant: related)) {
                                        RelatedItemChip(text: related.name) {}
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Attribution
                AttributionCard(wikipediaTitle: colorant.attribution.wikipediaTitle)
            }
            .padding()
        }
        .navigationTitle(colorant.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        ColorantsView()
            .environmentObject(DataManager())
    }
}
