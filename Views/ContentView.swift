
import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: SessionStore
    
    @State private var selectedScenario: Scenario?
    @State private var selectedLevel: AnxietyLevel?
    @State private var selectedPattern: BreathingPattern = .box
    
    @State private var startSession = false
    @State private var sessionComplete = false
    
    var body: some View {
        
        if selectedScenario == nil {
            
            ScenarioSelectionView(selectedScenario: $selectedScenario)
            
        } else if selectedLevel == nil {
            
            PreparationView(
                scenario: selectedScenario!,
                selectedLevel: $selectedLevel
            )
            
        } else if !startSession {
            
            PatternSelectionView(
                selectedPattern: $selectedPattern
            ) {
                startSession = true
            }
            
        } else if !sessionComplete {
            
            BreathingView(
                scenario: selectedScenario!,
                selectedLevel: selectedLevel!,
                pattern: selectedPattern,
                sessionComplete: $sessionComplete
            )
            
        } else {
            
            CompletionView(
                scenario: selectedScenario!,
                selectedLevel: selectedLevel!,
                onHome: {
                    selectedScenario = nil
                    selectedLevel = nil
                    startSession = false
                    sessionComplete = false
                }
            )
        }
    }
}
