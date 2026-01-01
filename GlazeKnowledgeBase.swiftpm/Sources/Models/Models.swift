import Foundation

// MARK: - ThemeMode
enum ThemeMode: String, CaseIterable {
    case system = "Sistem"
    case light = "Açık"
    case dark = "Koyu"
}

// MARK: - Attribution
struct Attribution: Codable, Hashable {
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    enum CodingKeys: String, CodingKey {
        case wikipediaTitle, wikipediaUrl, additionalSources
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        wikipediaTitle = try container.decodeIfPresent(String.self, forKey: .wikipediaTitle)
        wikipediaUrl = try container.decodeIfPresent(String.self, forKey: .wikipediaUrl)
        additionalSources = try container.decodeIfPresent([String].self, forKey: .additionalSources)
    }
    
    init(wikipediaTitle: String? = nil, wikipediaUrl: String? = nil, additionalSources: [String]? = nil) {
        self.wikipediaTitle = wikipediaTitle
        self.wikipediaUrl = wikipediaUrl
        self.additionalSources = additionalSources
    }
}

// MARK: - Safety Level
enum SafetyLevel: String, Codable, CaseIterable {
    case safe = "SAFE"
    case caution = "CAUTION"
    case irritant = "IRRITANT"
    case toxic = "TOXIC"
    
    var displayName: String {
        switch self {
        case .safe: return "Güvenli"
        case .caution: return "Dikkat"
        case .irritant: return "Tahriş Edici"
        case .toxic: return "Toksik"
        }
    }
}

// MARK: - Material
enum MaterialCategory: String, Codable, CaseIterable {
    case flux = "FLUX"
    case glassFormer = "GLASS_FORMER"
    case stabilizer = "STABILIZER"
    case clayBody = "CLAY_BODY"
    case opacifier = "OPACIFIER"
    
    var displayName: String {
        switch self {
        case .flux: return "Eritici"
        case .glassFormer: return "Cam Oluşturucu"
        case .stabilizer: return "Dengeleyici"
        case .clayBody: return "Kil Bünyesi"
        case .opacifier: return "Opaklaştırıcı"
        }
    }
}

struct Material: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let alternativeNames: [String]
    let category: MaterialCategory
    let description: String
    let characteristics: [String]
    let commonUses: [String]
    let safetyLevel: SafetyLevel
    let safetyNotes: String
    let temperatureRange: String
    let relatedMaterialIds: [String]
    let relatedColorantIds: [String]
    let relatedGlazeTypeIds: [String]
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    var attribution: Attribution {
        Attribution(wikipediaTitle: wikipediaTitle, wikipediaUrl: wikipediaUrl, additionalSources: additionalSources)
    }
}

// MARK: - Colorant
enum ColorFamily: String, Codable, CaseIterable {
    case blue = "BLUE"
    case green = "GREEN"
    case red = "RED"
    case yellow = "YELLOW"
    case brown = "BROWN"
    case black = "BLACK"
    case white = "WHITE"
    case multicolor = "MULTICOLOR"
    
    var displayName: String {
        switch self {
        case .blue: return "Mavi"
        case .green: return "Yeşil"
        case .red: return "Kırmızı"
        case .yellow: return "Sarı"
        case .brown: return "Kahverengi"
        case .black: return "Siyah"
        case .white: return "Beyaz"
        case .multicolor: return "Çok Renkli"
        }
    }
}

struct AtmosphereEffects: Codable, Hashable {
    let oxidation: String
    let reduction: String
}

struct Colorant: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let chemicalName: String
    let colorFamily: ColorFamily
    let description: String
    let colorCharacteristics: [String]
    let oxidationEffect: String
    let reductionEffect: String
    let temperatureSensitivity: String
    let safetyLevel: SafetyLevel
    let safetyNotes: String
    let historicalBackground: String
    let relatedColorantIds: [String]
    let relatedMaterialIds: [String]
    let relatedSurfaceEffectIds: [String]
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    var atmosphereEffects: AtmosphereEffects {
        AtmosphereEffects(oxidation: oxidationEffect, reduction: reductionEffect)
    }
    
    var attribution: Attribution {
        Attribution(wikipediaTitle: wikipediaTitle, wikipediaUrl: wikipediaUrl, additionalSources: additionalSources)
    }
}

// MARK: - GlazeType
enum GlazeCategory: String, Codable, CaseIterable {
    case matte = "MATTE"
    case glossy = "GLOSSY"
    case satin = "SATIN"
    case crystalline = "CRYSTALLINE"
    case celadon = "CELADON"
    case temmoku = "TEMMOKU"
    
    var displayName: String {
        switch self {
        case .matte: return "Mat"
        case .glossy: return "Parlak"
        case .satin: return "Saten"
        case .crystalline: return "Kristal"
        case .celadon: return "Seladon"
        case .temmoku: return "Temmoku"
        }
    }
}

struct GlazeType: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let category: GlazeCategory
    let description: String
    let visualCharacteristics: [String]
    let surfaceQuality: String
    let lightInteraction: String
    let typicalTemperatureRange: String
    let historicalContext: String
    let commonApplications: [String]
    let relatedGlazeTypeIds: [String]
    let relatedSurfaceEffectIds: [String]
    let relatedFiringTypeIds: [String]
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    var attribution: Attribution {
        Attribution(wikipediaTitle: wikipediaTitle, wikipediaUrl: wikipediaUrl, additionalSources: additionalSources)
    }
}

// MARK: - FiringType
enum FiringCategory: String, Codable, CaseIterable {
    case lowFire = "LOW_FIRE"
    case midFire = "MID_FIRE"
    case highFire = "HIGH_FIRE"
    case specialty = "SPECIALTY"
    
    var displayName: String {
        switch self {
        case .lowFire: return "Düşük"
        case .midFire: return "Orta"
        case .highFire: return "Yüksek"
        case .specialty: return "Özel"
        }
    }
}

enum FiringAtmosphere: String, Codable, CaseIterable {
    case oxidation = "OXIDATION"
    case reduction = "REDUCTION"
    case neutral = "NEUTRAL"
    case variable = "VARIABLE"
    
    var displayName: String {
        switch self {
        case .oxidation: return "Oksidasyon"
        case .reduction: return "Redüksiyon"
        case .neutral: return "Nötr"
        case .variable: return "Değişken"
        }
    }
}

struct FiringType: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let firingCategory: FiringCategory
    let description: String
    let temperatureRangeCelsius: String
    let temperatureRangeFahrenheit: String
    let coneRange: String
    let atmosphere: FiringAtmosphere
    let characteristics: [String]
    let historicalBackground: String
    let commonCeramicTypes: [String]
    let relatedGlazeTypeIds: [String]
    let relatedFiringTypeIds: [String]
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    var attribution: Attribution {
        Attribution(wikipediaTitle: wikipediaTitle, wikipediaUrl: wikipediaUrl, additionalSources: additionalSources)
    }
}

// MARK: - SurfaceEffect
enum EffectType: String, Codable, CaseIterable {
    case decorative = "DECORATIVE"
    case textural = "TEXTURAL"
    case colorVariation = "COLOR_VARIATION"
    case crystalline = "CRYSTALLINE"
    
    var displayName: String {
        switch self {
        case .decorative: return "Dekoratif"
        case .textural: return "Dokusal"
        case .colorVariation: return "Renk"
        case .crystalline: return "Kristal"
        }
    }
}

struct SurfaceEffect: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let effectType: EffectType
    let description: String
    let visualAppearance: String
    let causes: [String]
    let associatedFactors: [String]
    let historicalContext: String
    let notableExamples: [String]
    let relatedEffectIds: [String]
    let relatedGlazeTypeIds: [String]
    let relatedColorantIds: [String]
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    var attribution: Attribution {
        Attribution(wikipediaTitle: wikipediaTitle, wikipediaUrl: wikipediaUrl, additionalSources: additionalSources)
    }
}

// MARK: - SafetyInfo
enum SafetyCategory: String, Codable, CaseIterable {
    case materialSafety = "MATERIAL_SAFETY"
    case studioSafety = "STUDIO_SAFETY"
    case respiratory = "RESPIRATORY"
    
    var displayName: String {
        switch self {
        case .materialSafety: return "Malzeme"
        case .studioSafety: return "Stüdyo"
        case .respiratory: return "Solunum"
        }
    }
}

enum HazardType: String, Codable, CaseIterable {
    case inhalation = "INHALATION"
    case skinContact = "SKIN_CONTACT"
    case eyeContact = "EYE_CONTACT"
    case ingestion = "INGESTION"
    
    var displayName: String {
        switch self {
        case .inhalation: return "Soluma"
        case .skinContact: return "Cilt"
        case .eyeContact: return "Göz"
        case .ingestion: return "Yutma"
        }
    }
}

struct SafetyInfo: Codable, Identifiable, Hashable {
    let id: String
    let title: String
    let category: SafetyCategory
    let description: String
    let hazardTypes: [HazardType]
    let protectiveMeasures: [String]
    let symptoms: [String]
    let firstAidInfo: String
    let storageGuidelines: String
    let disposalGuidelines: String
    let regulatoryInfo: String
    let relatedMaterialIds: [String]
    let relatedColorantIds: [String]
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    var attribution: Attribution {
        Attribution(wikipediaTitle: wikipediaTitle, wikipediaUrl: wikipediaUrl, additionalSources: additionalSources)
    }
}

// MARK: - GlossaryTerm
enum GlossaryCategory: String, Codable, CaseIterable {
    case material = "MATERIAL"
    case technique = "TECHNIQUE"
    case firing = "FIRING"
    case general = "GENERAL"
    
    var displayName: String {
        switch self {
        case .material: return "Malzeme"
        case .technique: return "Teknik"
        case .firing: return "Pişirim"
        case .general: return "Genel"
        }
    }
}

struct GlossaryTerm: Codable, Identifiable, Hashable {
    let id: String
    let term: String
    let alternativeTerms: [String]
    let definition: String
    let extendedDescription: String
    let category: GlossaryCategory
    let relatedTermIds: [String]
    let relatedMaterialIds: [String]
    let relatedColorantIds: [String]
    let relatedGlazeTypeIds: [String]
    let wikipediaTitle: String?
    let wikipediaUrl: String?
    let additionalSources: [String]?
    
    var attribution: Attribution {
        Attribution(wikipediaTitle: wikipediaTitle, wikipediaUrl: wikipediaUrl, additionalSources: additionalSources)
    }
}

// MARK: - Recipe
struct Ingredient: Codable, Hashable {
    let name: String
    let amount: Double
}

struct Recipe: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let cone: String
    let atmosphere: String
    let ingredients: [Ingredient]
    let additives: [Ingredient]
    let instructions: String
    let image_name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, cone, atmosphere, ingredients, additives, instructions, image_name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        cone = try container.decode(String.self, forKey: .cone)
        atmosphere = try container.decode(String.self, forKey: .atmosphere)
        ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
        additives = try container.decodeIfPresent([Ingredient].self, forKey: .additives) ?? []
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions) ?? ""
        image_name = try container.decode(String.self, forKey: .image_name)
    }
}
