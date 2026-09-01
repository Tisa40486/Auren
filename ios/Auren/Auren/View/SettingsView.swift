import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var l10n: LocalizationManager
    @AppStorage("appTheme") private var selectedTheme = AppTheme.dark.rawValue
    @AppStorage("appLanguage") private var selectedLanguage = AppLanguage.system.rawValue

    var body: some View {
        Form {
            Section {
                Picker(selection: $selectedLanguage) {
                    ForEach(AppLanguage.allCases) { language in
                        HStack {
                            Text(language.flag)
                            Text(language.title)
                        }
                        .tag(language.rawValue)
                    }
                } label: {
                    Label(l10n.tr(.appLanguageTitle), systemImage: "globe")
                        .foregroundStyle(Color.aurenTextPrimary)
                }
                .pickerStyle(.navigationLink)
            } header: {
                Text(l10n.tr(.general))
            } footer: {
                Text(l10n.tr(.languageFooter))
            }

            Section {
                Picker(selection: $selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.title)
                            .tag(theme.rawValue)
                    }
                } label: {
                    Label(l10n.tr(.theme), systemImage: "circle.lefthalf.filled")
                        .foregroundStyle(Color.aurenTextPrimary)
                }
                .pickerStyle(.navigationLink)
            } header: {
                Text(l10n.tr(.appearance))
            }

            Section(l10n.tr(.about)) {
                HStack {
                    Label(l10n.tr(.version), systemImage: "info.circle")
                        .foregroundStyle(Color.aurenTextPrimary)
                    Spacer()
                    Text("1.0.0")
                        .foregroundStyle(Color.aurenTextSecondary)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.aurenBackground)
        .navigationTitle(l10n.tr(.settings))
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environmentObject(LocalizationManager.shared)
}
