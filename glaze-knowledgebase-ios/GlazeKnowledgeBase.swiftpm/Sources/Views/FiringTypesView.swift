import SwiftUI

struct FiringTypesView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchQuery = ""
    
    var filteredFiringTypes: [FiringType] {
        dataManager.searchFiringTypes(query: searchQuery)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Pişirim Türleri")
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
            } else if filteredFiringTypes.isEmpty {
                Spacer()
                EmptyStateView()
                Spacer()
            } else {
                List(filteredFiringTypes) { firingType in
                    NavigationLink(value: FiringTypeDetailNavigation(firingType: firingType)) {
                        FiringTypeRow(firingType: firingType)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Pişirim")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FiringTypeRow: View {
    let firingType: FiringType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(firingType.name)
                .font(.headline)
            
            HStack(spacing: 8) {
                InfoChip(text: firingType.firingCategory.displayName)
                InfoChip(text: firingType.atmosphere.displayName)
            }
            
            Text(firingType.description)
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

// MARK: - FiringType Detail View
struct FiringTypeDetailView: View {
    let firingType: FiringType
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Categories
                HStack(spacing: 8) {
                    InfoChip(text: firingType.firingCategory.displayName)
                    InfoChip(text: firingType.atmosphere.displayName)
                }
                
                // Description
                Text(firingType.description)
                    .font(.body)
                
                // Temperature Info Card
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(firingType.temperatureRangeCelsius)
                                .font(.headline)
                            Text(firingType.temperatureRangeFahrenheit)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Koni")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(firingType.coneRange)
                                .font(.headline)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Characteristics
                if !firingType.characteristics.isEmpty {
                    SectionTitle(title: "Özellikler")
                    ForEach(firingType.characteristics, id: \.self) { char in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(char)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Common Ceramic Types
                if !firingType.commonCeramicTypes.isEmpty {
                    SectionTitle(title: "Yaygın Seramik Türleri")
                    ForEach(firingType.commonCeramicTypes, id: \.self) { type in
                        HStack(alignment: .top, spacing: 8) {
                            Text("•")
                            Text(type)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Historical Background
                SectionTitle(title: "Tarih")
                Text(firingType.historicalBackground)
                    .font(.subheadline)
                
                // Attribution
                AttributionCard(wikipediaTitle: firingType.attribution.wikipediaTitle)
            }
            .padding()
        }
        .navigationTitle(firingType.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        FiringTypesView()
            .environmentObject(DataManager())
    }
}
