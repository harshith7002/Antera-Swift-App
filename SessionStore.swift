import Foundation
import SwiftUI

// MARK: - Single Session Entry
struct SessionEntry: Codable, Identifiable {
    let id: UUID
    let date: Date
    let scenario: String
    let anxietyLevel: String
    
    init(scenario: String, anxietyLevel: String) {
        self.id = UUID()
        self.date = Date()
        self.scenario = scenario
        self.anxietyLevel = anxietyLevel
    }
}

// MARK: - Session Store (ObservableObject)
class SessionStore: ObservableObject {
    
    @Published var sessions: [SessionEntry] = []
    
    private let key = "antera_sessions"
    
    init() {
        load()
    }
    
    func save(scenario: String, anxietyLevel: String) {
        let entry = SessionEntry(scenario: scenario, anxietyLevel: anxietyLevel)
        sessions.append(entry)
        persist()
    }
    
    func sessionsThisWeek() -> [SessionEntry] {
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return sessions.filter { $0.date >= weekAgo }
    }
    
    func countPerDay() -> [(String, Int)] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        var counts: [String: Int] = [:]
        
        for session in sessionsThisWeek() {
            let day = formatter.string(from: session.date)
            counts[day, default: 0] += 1
        }
        
        return counts.sorted { $0.key < $1.key }
    }
    
    private func persist() {
        if let encoded = try? JSONEncoder().encode(sessions) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([SessionEntry].self, from: data) {
            sessions = decoded
        }
    }
}
