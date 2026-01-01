import SwiftUI

struct MaterialsView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchQuery = ""
    
    var filteredMaterials: [Material] {
        dataManager.searchMaterials(query: searchQuery)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Hammaddeler")
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
            } else if filteredMaterials.isEmpty {
                Spacer()
                EmptyStateView()
                Spacer()
            } else {
                List(filteredMaterials) { material in
                    NavigationLink(value: MaterialDetailNavigation(material: material)) {
                        MaterialRow(material: material)
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

struct MaterialRow: View {
    let material: Material
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(material.name)
                    .font(.headline)
                Spacer()
                SafetyBadge(safetyLevel: material.safetyLevel)
            }
            
            InfoChip(text: material.category.displayName)
            
            Text(material.description)
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

// MARK: - Material Detail View
struct MaterialDetailView: View {
    let material: Material
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header badges
                HStack(spacing: 8) {
                    InfoChip(text: material.category.displayName)
                    SafetyBadge(safetyLevel: material.safetyLevel)
                }
                
                // Description
                Text(material.description)
                    .font(.body)
                
                // Characteristics
                if !material.characteristics.isEmpty {
                    SectionTitle(title: "Özellikler")
                    ForEach(material.characteristics, id: \.self) { char in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(char)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Common Uses
                if !material.commonUses.isEmpty {
                    SectionTitle(title: "Kullanım")
                    ForEach(material.commonUses, id: \.self) { use in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(use)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Temperature
                SectionTitle(title: "Sıcaklık")
                Text(material.temperatureRange)
                    .font(.subheadline)
                
                // Safety
                SectionTitle(title: "Güvenlik")
                Text(material.safetyNotes)
                    .font(.subheadline)
                
                // Related Materials
                if !material.relatedMaterialIds.isEmpty {
                    let relatedMaterials = dataManager.getMaterials(ids: material.relatedMaterialIds)
                    if !relatedMaterials.isEmpty {
                        SectionTitle(title: "İlgili Hammaddeler")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(relatedMaterials) { related in
                                    NavigationLink(value: MaterialDetailNavigation(material: related)) {
                                        RelatedItemChip(text: related.name) {}
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Attribution
                AttributionCard(wikipediaTitle: material.attribution.wikipediaTitle)
            }
            .padding()
        }
        .navigationTitle(material.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        MaterialsView()
            .environmentObject(DataManager())
    }
}
