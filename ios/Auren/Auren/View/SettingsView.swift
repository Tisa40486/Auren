import SwiftUI

struct SettingsView: View {
    @AppStorage("appTheme") private var selectedTheme = AppTheme.dark.rawValue

    var body: some View {
        Form {
            Section("Appearance") {
                Picker("Theme", selection: $selectedTheme) {
                    ForEach(AppTheme.allCases) { theme in
                        Text(theme.title)
                            .tag(theme.rawValue)
                    }
                }
                .pickerStyle(.navigationLink)
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.aurenBackground)
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
