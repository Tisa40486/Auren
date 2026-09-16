import SwiftUI
import FirebaseDatabase

struct ContentView: View {
    @EnvironmentObject private var session: SessionManager
    @State private var isDatabaseConnected = false
    @State private var connectionHandle: DatabaseHandle?

    private let connectionReference = Database.database(
        url: "https://auren-mattis-default-rtdb.europe-west1.firebasedatabase.app"
    )
    .reference()
    .child(".info/connected")

    var body: some View {
        Group {
            if session.isAuthenticated {
                RootView()
            } else if isDatabaseConnected {
                NavigationStack {
                    LoginView()
                }
            } else {
                ProgressView()
                    .tint(Color.aurenGold)
            }
        }
        .task {
            startConnectionMonitoring()
        }
        .onDisappear {
            stopConnectionMonitoring()
        }
    }

    private func startConnectionMonitoring() {
        guard connectionHandle == nil else { return }

        connectionHandle = connectionReference.observe(
            .value,
            with: { snapshot in
                let connected = snapshot.value as? Bool ?? false

                Task { @MainActor in
                    if connected {
                        print("[Firebase] Realtime Database connected.")
                    } else {
                        print("[Firebase] Realtime Database disconnected.")
                    }

                    isDatabaseConnected = connected
                }
            },
            withCancel: { error in
                Task { @MainActor in
                    print("[Firebase] Realtime Database connection failed: \(error.localizedDescription)")
                    isDatabaseConnected = false
                }
            }
        )
    }

    private func stopConnectionMonitoring() {
        if let connectionHandle {
            connectionReference.removeObserver(withHandle: connectionHandle)
            self.connectionHandle = nil
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SessionManager())
        .environmentObject(LocalizationManager.shared)
}
