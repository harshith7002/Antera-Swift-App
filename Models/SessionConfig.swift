import Foundation

struct SessionConfig {
    var scenario: Scenario
    var anxietyLevel: AnxietyLevel
    var fear: String
    
    var totalDuration: Int {
        anxietyLevel.duration
    }
}
