import Foundation

enum BreathingPattern: String, CaseIterable, Codable {
    case box = "Box Breathing"
    case fourSevenEight = "4-7-8"
    case equal = "Equal Breathing"
    
    var inhale: Double {
        switch self {
        case .box: return 4
        case .fourSevenEight: return 4
        case .equal: return 5
        }
    }
    
    var hold: Double {
        switch self {
        case .box: return 4
        case .fourSevenEight: return 7
        case .equal: return 0
        }
    }
    
    var exhale: Double {
        switch self {
        case .box: return 4
        case .fourSevenEight: return 8
        case .equal: return 5
        }
    }
}
