
import SwiftUI

@main
struct AnteraApp: App {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @StateObject private var store = SessionStore()
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                ContentView()
                    .environmentObject(store)
            } else {
                OnboardingView()
                    .environmentObject(store)
            }
        }
    }
}
