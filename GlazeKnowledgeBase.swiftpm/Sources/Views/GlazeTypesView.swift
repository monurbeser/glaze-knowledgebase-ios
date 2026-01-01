import SwiftUI

struct GlazeTypesView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchQuery = ""
    
    var filteredGlazeTypes: [GlazeType] {
        dataManager.searchGlazeTypes(query: searchQuery)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Sır Tipleri")
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
            } else if filteredGlazeTypes.isEmpty {
                Spacer()
                EmptyStateView()
                Spacer()
            } else {
                List(filteredGlazeTypes) { glazeType in
                    NavigationLink(value: GlazeTypeDetailNavigation(glazeType: glazeType)) {
                        GlazeTypeRow(glazeType: glazeType)
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

struct GlazeTypeRow: View {
    let glazeType: GlazeType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(glazeType.name)
                .font(.headline)
            
            InfoChip(text: glazeType.category.displayName)
            
            Text(glazeType.description)
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

// MARK: - GlazeType Detail View
struct GlazeTypeDetailView: View {
    let glazeType: GlazeType
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Category
                InfoChip(text: glazeType.category.displayName)
                
                // Description
                Text(glazeType.description)
                    .font(.body)
                
                // Visual Characteristics
                if !glazeType.visualCharacteristics.isEmpty {
                    SectionTitle(title: "Görsel Özellikler")
                    ForEach(glazeType.visualCharacteristics, id: \.self) { char in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(char)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Surface Quality
                SectionTitle(title: "Yüzey")
                Text(glazeType.surfaceQuality)
                    .font(.subheadline)
                
                // Light Interaction
                SectionTitle(title: "Işık")
                Text(glazeType.lightInteraction)
                    .font(.subheadline)
                
                // Temperature Range
                SectionTitle(title: "Sıcaklık")
                Text(glazeType.typicalTemperatureRange)
                    .font(.subheadline)
                
                // Historical Context
                SectionTitle(title: "Tarih")
                Text(glazeType.historicalContext)
                    .font(.subheadline)
                
                // Common Applications
                if !glazeType.commonApplications.isEmpty {
                    SectionTitle(title: "Kullanım Alanları")
                    ForEach(glazeType.commonApplications, id: \.self) { app in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(app)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Related Glaze Types
                if !glazeType.relatedGlazeTypeIds.isEmpty {
                    let relatedTypes = dataManager.getGlazeTypes(ids: glazeType.relatedGlazeTypeIds)
                    if !relatedTypes.isEmpty {
                        SectionTitle(title: "İlgili Sır Tipleri")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(relatedTypes) { related in
                                    NavigationLink(value: GlazeTypeDetailNavigation(glazeType: related)) {
                                        RelatedItemChip(text: related.name) {}
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Attribution
                AttributionCard(wikipediaTitle: glazeType.attribution.wikipediaTitle)
            }
            .padding()
        }
        .navigationTitle(glazeType.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        GlazeTypesView()
            .environmentObject(DataManager())
    }
}
