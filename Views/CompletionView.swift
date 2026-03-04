import SwiftUI

struct CompletionView: View {
    
    let scenario: Scenario
    let selectedLevel: AnxietyLevel
    let onHome: () -> Void
    
    @EnvironmentObject var store: SessionStore
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [scenario.color.opacity(0.8), .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                
                Text("You Did It.")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Text("You faced your \(scenario.name) with courage.")
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                
                Text("Anxiety level: \(selectedLevel.rawValue)")
                    .foregroundColor(selectedLevel.color)
                    .font(.headline)
                
                Button {
                    onHome()
                } label: {
                    Text("Return Home")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 40)
                .padding(.top, 20)
            }
        }
        .onAppear {
            store.save(
                scenario: scenario.name,
                anxietyLevel: selectedLevel.rawValue
            )
        }
    }
}
