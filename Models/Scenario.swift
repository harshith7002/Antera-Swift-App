import SwiftUI

struct Scenario: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let color: Color
    
    static func == (lhs: Scenario, rhs: Scenario) -> Bool {
        lhs.id == rhs.id
    }
}

let scenarios: [Scenario] = [
    Scenario(name: "Exam", color: .blue),
    Scenario(name: "Presentation", color: .purple),
    Scenario(name: "Interview", color: .green)
]
