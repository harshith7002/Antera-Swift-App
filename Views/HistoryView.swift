import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var store: SessionStore
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if store.sessions.isEmpty {
                    
                    VStack(spacing: 12) {
                        Image(systemName: "clock.arrow.circlepath")
                            .font(.system(size: 40))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("No Sessions Yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("Complete a breathing session to see it here.")
                            .font(.subheadline)
                            .foregroundColor(.gray.opacity(0.6))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .padding()
                    
                } else {
                    
                    List(store.sessions.reversed()) { session in
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text(session.scenario) // ✅ FIXED
                                .font(.headline)
                            
                            Text("Anxiety: \(session.anxietyLevel)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text(session.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Session History")
        }
    }
}
