import Foundation
import SwiftUI

@MainActor
class DataManager: ObservableObject {
    @Published var materials: [Material] = []
    @Published var colorants: [Colorant] = []
    @Published var glazeTypes: [GlazeType] = []
    @Published var firingTypes: [FiringType] = []
    @Published var surfaceEffects: [SurfaceEffect] = []
    @Published var safetyInfo: [SafetyInfo] = []
    @Published var glossaryTerms: [GlossaryTerm] = []
    @Published var recipes: [Recipe] = []
    @Published var isLoading = true
    
    init() {
        Task {
            await loadAllData()
        }
    }
    
    func loadAllData() async {
        isLoading = true
        
        // Load all JSON data
        materials = loadJSON("materials")
        colorants = loadJSON("colorants")
        glazeTypes = loadJSON("glaze_types")
        firingTypes = loadJSON("firing_types")
        surfaceEffects = loadJSON("surface_effects")
        safetyInfo = loadJSON("safety_info")
        glossaryTerms = loadJSON("glossary_terms")
        recipes = loadJSON("recipes")
        
        isLoading = false
    }
    
    private func loadJSON<T: Decodable>(_ filename: String) -> [T] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("Could not find \(filename).json in bundle")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([T].self, from: data)
        } catch {
            print("Error loading \(filename).json: \(error)")
            return []
        }
    }
    
    // MARK: - Search Functions
    func searchMaterials(query: String) -> [Material] {
        if query.isEmpty { return materials }
        let lowercased = query.lowercased()
        return materials.filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased) ||
            $0.alternativeNames.contains { $0.lowercased().contains(lowercased) }
        }
    }
    
    func searchColorants(query: String) -> [Colorant] {
        if query.isEmpty { return colorants }
        let lowercased = query.lowercased()
        return colorants.filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.chemicalName.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased)
        }
    }
    
    func searchGlazeTypes(query: String) -> [GlazeType] {
        if query.isEmpty { return glazeTypes }
        let lowercased = query.lowercased()
        return glazeTypes.filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased)
        }
    }
    
    func searchFiringTypes(query: String) -> [FiringType] {
        if query.isEmpty { return firingTypes }
        let lowercased = query.lowercased()
        return firingTypes.filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased)
        }
    }
    
    func searchSurfaceEffects(query: String) -> [SurfaceEffect] {
        if query.isEmpty { return surfaceEffects }
        let lowercased = query.lowercased()
        return surfaceEffects.filter {
            $0.name.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased)
        }
    }
    
    func searchSafetyInfo(query: String) -> [SafetyInfo] {
        if query.isEmpty { return safetyInfo }
        let lowercased = query.lowercased()
        return safetyInfo.filter {
            $0.title.lowercased().contains(lowercased) ||
            $0.description.lowercased().contains(lowercased)
        }
    }
    
    func searchGlossaryTerms(query: String) -> [GlossaryTerm] {
        if query.isEmpty { return glossaryTerms }
        let lowercased = query.lowercased()
        return glossaryTerms.filter {
            $0.term.lowercased().contains(lowercased) ||
            $0.definition.lowercased().contains(lowercased) ||
            $0.alternativeTerms.contains { $0.lowercased().contains(lowercased) }
        }
    }
    
    // MARK: - Get by ID Functions
    func getMaterial(id: String) -> Material? {
        materials.first { $0.id == id }
    }
    
    func getColorant(id: String) -> Colorant? {
        colorants.first { $0.id == id }
    }
    
    func getGlazeType(id: String) -> GlazeType? {
        glazeTypes.first { $0.id == id }
    }
    
    func getFiringType(id: String) -> FiringType? {
        firingTypes.first { $0.id == id }
    }
    
    func getSurfaceEffect(id: String) -> SurfaceEffect? {
        surfaceEffects.first { $0.id == id }
    }
    
    func getSafetyInfo(id: String) -> SafetyInfo? {
        safetyInfo.first { $0.id == id }
    }
    
    func getGlossaryTerm(id: String) -> GlossaryTerm? {
        glossaryTerms.first { $0.id == id }
    }
    
    func getRecipe(id: Int) -> Recipe? {
        recipes.first { $0.id == id }
    }
    
    // MARK: - Get Multiple by IDs
    func getMaterials(ids: [String]) -> [Material] {
        materials.filter { ids.contains($0.id) }
    }
    
    func getColorants(ids: [String]) -> [Colorant] {
        colorants.filter { ids.contains($0.id) }
    }
    
    func getGlazeTypes(ids: [String]) -> [GlazeType] {
        glazeTypes.filter { ids.contains($0.id) }
    }
}
