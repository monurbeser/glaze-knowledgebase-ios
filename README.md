# Glaze Knowledge Base - iOS

Bu proje, Android Jetpack Compose uygulamasının iOS (SwiftUI) versiyonudur.

## Seramik Bilgi Bankası

Hammaddeler, Sır Türleri, Renk Vericiler, Pişirim Türleri hakkında pratik bilgiler sunan bir iOS uygulaması.

## Özellikler

- 📦 **Hammaddeler**: Eriticiler, cam oluşturucular, dengeleyiciler ve diğer seramik malzemeleri
- 🎨 **Renk Vericiler**: Oksitler ve pigmentler, renk aileleri ve güvenlik bilgileri
- 📋 **Sır Reçeteleri**: Çeşitli sır reçeteleri ve bileşenleri
- ✨ **Sır Tipleri**: Mat, parlak, saten, kristal, seladon, temmoku
- 🔥 **Pişirim Türleri**: Sıcaklık aralıkları, atmosfer ve koni bilgileri
- 🌊 **Yüzey Efektleri**: Kristal, crawling, oil spot ve diğer efektler
- ⚠️ **Güvenlik Bilgileri**: Malzeme güvenliği, ilk yardım, koruma önlemleri
- 📖 **Sözlük**: Seramik terminolojisi

## Kurulum

### Swift Playgrounds (iPad/Mac)
1. `GlazeKnowledgeBase.swiftpm` klasörünü Swift Playgrounds uygulamasına açın
2. Uygulama otomatik olarak çalışacaktır

### Xcode
1. `GlazeKnowledgeBase.swiftpm` dosyasını Xcode'da açın
2. iOS Simulator veya gerçek cihazda çalıştırın
3. Minimum iOS 17.0 gereklidir

## Proje Yapısı

```
GlazeKnowledgeBase.swiftpm/
├── Package.swift                    # Swift Package tanımı
└── Sources/
    ├── GlazeKnowledgeBaseApp.swift  # Ana uygulama giriş noktası
    ├── Theme.swift                  # Renk ve tema tanımları
    ├── Models/
    │   └── Models.swift             # Veri modelleri (Material, Colorant, vb.)
    ├── Data/
    │   └── DataManager.swift        # JSON veri yükleyici
    ├── Components/
    │   └── CommonComponents.swift   # Ortak UI bileşenleri
    ├── Views/
    │   ├── ContentView.swift        # Ana tab bar
    │   ├── HomeView.swift           # Ana sayfa
    │   ├── MaterialsView.swift      # Hammaddeler listesi ve detay
    │   ├── ColorantsView.swift      # Renk vericiler listesi ve detay
    │   ├── GlazeTypesView.swift     # Sır tipleri listesi ve detay
    │   ├── FiringTypesView.swift    # Pişirim türleri listesi ve detay
    │   ├── SurfaceEffectsView.swift # Yüzey efektleri listesi ve detay
    │   ├── SafetyInfoView.swift     # Güvenlik bilgileri listesi ve detay
    │   ├── GlossaryView.swift       # Sözlük listesi ve detay
    │   ├── RecipesView.swift        # Reçeteler listesi ve detay
    │   └── SettingsView.swift       # Ayarlar ve hakkında
    └── Resources/
        ├── materials.json           # Hammadde verileri
        ├── colorants.json           # Renk verici verileri
        ├── glaze_types.json         # Sır tipi verileri
        ├── firing_types.json        # Pişirim türü verileri
        ├── surface_effects.json     # Yüzey efekti verileri
        ├── safety_info.json         # Güvenlik bilgileri
        ├── glossary_terms.json      # Sözlük terimleri
        └── recipes.json             # Sır reçeteleri
```

## Android vs iOS Karşılaştırması

| Android (Kotlin/Compose) | iOS (Swift/SwiftUI) |
|-------------------------|---------------------|
| Jetpack Compose | SwiftUI |
| Hilt (DI) | @EnvironmentObject |
| Room Database | JSON + In-Memory |
| Navigation Component | NavigationStack |
| Material 3 | Native iOS Design |
| StateFlow | @Published + Combine |
| ViewModel | ObservableObject |

## Tema Desteği

Uygulama üç tema modunu destekler:
- 🌙 Koyu mod
- ☀️ Açık mod
- 📱 Sistem teması

## Gereksinimler

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Geliştirici

**Pia Ceramic**

## Lisans

Bu uygulama bilgilendirme amaçlıdır. Kimyasal kullanımında yerel güvenlik talimatlarına uyunuz.

---

© 2024 Pia Ceramic - Seramik Bilgi Bankası
