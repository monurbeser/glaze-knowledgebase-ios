import SwiftUI

// MARK: - Search Bar
struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Ara…"
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(.plain)
            
            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// MARK: - Safety Badge
struct SafetyBadge: View {
    let safetyLevel: SafetyLevel
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: iconName)
                .font(.caption)
            Text(safetyLevel.displayName)
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundColor(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.15))
        .cornerRadius(8)
    }
    
    private var color: Color {
        switch safetyLevel {
        case .safe: return .safetySafe
        case .caution, .irritant: return .safetyCaution
        case .toxic: return .safetyToxic
        }
    }
    
    private var iconName: String {
        switch safetyLevel {
        case .safe: return "checkmark.circle.fill"
        case .caution: return "exclamationmark.triangle.fill"
        case .irritant: return "exclamationmark.circle.fill"
        case .toxic: return "xmark.octagon.fill"
        }
    }
}

// MARK: - Info Chip
struct InfoChip: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.ceramicPrimary)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.ceramicPrimaryContainer.opacity(0.5))
            .cornerRadius(8)
    }
}

// MARK: - Section Title
struct SectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.ceramicPrimary)
            .padding(.top, 8)
    }
}

// MARK: - Attribution Card
struct AttributionCard: View {
    let wikipediaTitle: String?
    
    var body: some View {
        if let title = wikipediaTitle {
            HStack(spacing: 8) {
                Image(systemName: "info.circle")
                    .foregroundColor(.secondary)
                VStack(alignment: .leading, spacing: 2) {
                    Text("Kaynak")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(title)
                        .font(.caption)
                }
                Spacer()
            }
            .padding(12)
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
    }
}

// MARK: - Related Item Chip
struct RelatedItemChip: View {
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.ceramicPrimary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Color.ceramicPrimaryContainer.opacity(0.7))
                .cornerRadius(8)
        }
    }
}

// MARK: - Info Badge (for Recipe)
struct InfoBadge: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(color)
            .cornerRadius(8)
    }
}

// MARK: - Loading View
struct LoadingView: View {
    var message: String = "Hazırlanıyor…"
    
    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text(message)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Empty State View
struct EmptyStateView: View {
    var message: String = "Sonuç bulunamadı"
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text(message)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Card View Modifier
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}
