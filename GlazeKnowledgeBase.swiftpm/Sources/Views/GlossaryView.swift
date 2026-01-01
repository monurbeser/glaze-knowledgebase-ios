import SwiftUI

struct GlossaryView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var searchQuery = ""
    
    var filteredTerms: [GlossaryTerm] {
        dataManager.searchGlossaryTerms(query: searchQuery)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Seramik Sözlüğü")
                    .font(.title)
                    .fontWeight(.bold)
                
                SearchBar(text: $searchQuery)
            }
            .padding()
            
            if dataManager.isLoading {
                Spacer()
                LoadingView()
                Spacer()
            } else if filteredTerms.isEmpty {
                Spacer()
                EmptyStateView()
                Spacer()
            } else {
                List(filteredTerms) { term in
                    NavigationLink(value: GlossaryTermDetailNavigation(glossaryTerm: term)) {
                        GlossaryTermRow(term: term)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Sözlük")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct GlossaryTermRow: View {
    let term: GlossaryTerm
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(term.term)
                .font(.headline)
            
            InfoChip(text: term.category.displayName)
            
            Text(term.definition)
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

struct GlossaryTermDetailView: View {
    let glossaryTerm: GlossaryTerm
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                InfoChip(text: glossaryTerm.category.displayName)
                
                if !glossaryTerm.alternativeTerms.isEmpty {
                    Text("Diğer: \(glossaryTerm.alternativeTerms.joined(separator: ", "))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Text(glossaryTerm.definition)
                    .font(.headline)
                
                Text(glossaryTerm.extendedDescription)
                    .font(.body)
                
                AttributionCard(wikipediaTitle: glossaryTerm.attribution.wikipediaTitle)
            }
            .padding()
        }
        .navigationTitle(glossaryTerm.term)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        GlossaryView()
            .environmentObject(DataManager())
    }
}
