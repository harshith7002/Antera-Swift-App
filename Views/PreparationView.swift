import SwiftUI

struct PreparationView: View {
    
    let scenario: Scenario
    @Binding var selectedLevel: AnxietyLevel?
    
    var body: some View {
        VStack(spacing: 25) {
            
            Text("How intense is your anxiety?")
                .font(.title2)
                .foregroundColor(.white)
            
            ForEach(AnxietyLevel.allCases) { level in
                Button {
                    selectedLevel = level
                } label: {
                    Text(level.rawValue)
                        .frame(width: 250, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.2))
                        )
                        .foregroundColor(.white)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [scenario.color.opacity(0.8), .black],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
