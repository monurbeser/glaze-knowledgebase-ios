import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var dataManager: DataManager
    
    var body: some View {
        VStack(spacing: 0) {
            if dataManager.isLoading {
                Spacer()
                LoadingView()
                Spacer()
            } else if dataManager.recipes.isEmpty {
                Spacer()
                EmptyStateView(message: "Reçete bulunamadı")
                Spacer()
            } else {
                List(dataManager.recipes) { recipe in
                    NavigationLink(value: RecipeDetailNavigation(recipe: recipe)) {
                        RecipeRow(recipe: recipe)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Sır Reçeteleri")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(recipe.name)
                .font(.headline)
            
            HStack(spacing: 8) {
                InfoBadge(text: recipe.cone, color: .ceramicPrimary)
                InfoBadge(text: recipe.atmosphere, color: Color(red: 74/255, green: 101/255, blue: 114/255))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Recipe Image placeholder
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.ceramicPrimaryContainer.opacity(0.3))
                        .frame(height: 200)
                    
                    VStack {
                        Image(systemName: "photo")
                            .font(.system(size: 48))
                            .foregroundColor(.ceramicPrimary.opacity(0.5))
                        Text(recipe.image_name)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                // Recipe Name
                Text(recipe.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                // Badges
                HStack(spacing: 8) {
                    InfoBadge(text: recipe.cone, color: .ceramicPrimary)
                    InfoBadge(text: recipe.atmosphere, color: Color(red: 74/255, green: 101/255, blue: 114/255))
                }
                
                Divider()
                
                // Base Recipe
                SectionTitle(title: "Ana Reçete (Base)")
                ForEach(recipe.ingredients, id: \.name) { ingredient in
                    IngredientRow(ingredient: ingredient, isAdditive: false)
                }
                
                // Additives
                if !recipe.additives.isEmpty {
                    SectionTitle(title: "Eklemeler (Additives)")
                    ForEach(recipe.additives, id: \.name) { additive in
                        IngredientRow(ingredient: additive, isAdditive: true)
                    }
                }
                
                // Instructions
                if !recipe.instructions.isEmpty {
                    SectionTitle(title: "Notlar ve Talimatlar")
                    Text(recipe.instructions)
                        .font(.subheadline)
                }
            }
            .padding()
        }
        .navigationTitle("Reçete")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct IngredientRow: View {
    let ingredient: Ingredient
    let isAdditive: Bool
    
    var body: some View {
        HStack {
            Text(ingredient.name)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(String(format: "%.1f", ingredient.amount))
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(isAdditive ? .safetyToxic : .primary)
        }
        .padding(.vertical, 2)
    }
}

#Preview {
    NavigationStack {
        RecipesView()
            .environmentObject(DataManager())
    }
}
