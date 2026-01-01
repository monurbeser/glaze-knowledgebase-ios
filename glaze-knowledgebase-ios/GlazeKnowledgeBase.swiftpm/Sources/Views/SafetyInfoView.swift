import SwiftUI

struct SafetyInfoView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchQuery = ""
    
    var filteredSafetyInfo: [SafetyInfo] {
        dataManager.searchSafetyInfo(query: searchQuery)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                Text("Güvenlik Bilgileri")
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
            } else if filteredSafetyInfo.isEmpty {
                Spacer()
                EmptyStateView()
                Spacer()
            } else {
                List(filteredSafetyInfo) { info in
                    NavigationLink(value: SafetyInfoDetailNavigation(safetyInfo: info)) {
                        SafetyInfoRow(info: info)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Güvenlik")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SafetyInfoRow: View {
    let info: SafetyInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(info.title)
                .font(.headline)
            
            HStack(spacing: 8) {
                InfoChip(text: info.category.displayName)
                ForEach(info.hazardTypes.prefix(2), id: \.self) { hazard in
                    InfoChip(text: hazard.displayName)
                }
            }
            
            Text(info.description)
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

// MARK: - SafetyInfo Detail View
struct SafetyInfoDetailView: View {
    let safetyInfo: SafetyInfo
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Category and Hazard Types
                HStack(spacing: 8) {
                    InfoChip(text: safetyInfo.category.displayName)
                    ForEach(safetyInfo.hazardTypes, id: \.self) { hazard in
                        InfoChip(text: hazard.displayName)
                    }
                }
                
                // Description
                Text(safetyInfo.description)
                    .font(.body)
                
                // Protective Measures
                if !safetyInfo.protectiveMeasures.isEmpty {
                    SectionTitle(title: "Koruma Önlemleri")
                    ForEach(safetyInfo.protectiveMeasures, id: \.self) { measure in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "checkmark.shield.fill")
                                .foregroundColor(.safetySafe)
                                .font(.caption)
                            Text(measure)
                        }
                        .font(.subheadline)
                    }
                }
                
                // Symptoms
                if !safetyInfo.symptoms.isEmpty {
                    SectionTitle(title: "Belirtiler")
                    ForEach(safetyInfo.symptoms, id: \.self) { symptom in
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.safetyCaution)
                                .font(.caption)
                            Text(symptom)
                        }
                        .font(.subheadline)
                    }
                }
                
                // First Aid
                if !safetyInfo.firstAidInfo.isEmpty && safetyInfo.firstAidInfo != "-" {
                    SectionTitle(title: "İlk Yardım")
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "cross.case.fill")
                            .foregroundColor(.safetyToxic)
                        Text(safetyInfo.firstAidInfo)
                    }
                    .font(.subheadline)
                }
                
                // Storage Guidelines
                if !safetyInfo.storageGuidelines.isEmpty && safetyInfo.storageGuidelines != "-" {
                    SectionTitle(title: "Saklama")
                    Text(safetyInfo.storageGuidelines)
                        .font(.subheadline)
                }
                
                // Disposal Guidelines
                if !safetyInfo.disposalGuidelines.isEmpty && safetyInfo.disposalGuidelines != "-" {
                    SectionTitle(title: "Bertaraf")
                    Text(safetyInfo.disposalGuidelines)
                        .font(.subheadline)
                }
                
                // Regulatory Info
                if !safetyInfo.regulatoryInfo.isEmpty && safetyInfo.regulatoryInfo != "-" {
                    SectionTitle(title: "Yasal Düzenlemeler")
                    Text(safetyInfo.regulatoryInfo)
                        .font(.subheadline)
                }
                
                // Attribution
                AttributionCard(wikipediaTitle: safetyInfo.attribution.wikipediaTitle)
            }
            .padding()
        }
        .navigationTitle(safetyInfo.title)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SafetyInfoView()
            .environmentObject(DataManager())
    }
}
