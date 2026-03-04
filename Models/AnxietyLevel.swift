import SwiftUI

enum AnxietyLevel: String, CaseIterable, Identifiable, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var id: String { rawValue }
    
    var duration: Int {
        switch self {
        case .low:
            return 40
        case .medium:
            return 60
        case .high:
            return 20
        }
    }
    
    var color: Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
    
    var description: String {
        switch self {
        case .low:
            return "Mild tension. Quick reset."
        case .medium:
            return "Noticeable stress. Steady breathing."
        case .high:
            return "Overwhelming anxiety. Deep calming needed."
        }
    }
    
    var emoji: String {
        switch self {
        case .low:
            return "😌"
        case .medium:
            return "😰"
        case .high:
            return "😱"
        }
    }
}
