import SwiftUI

struct BreathingView: View {
    
    let scenario: Scenario
    let selectedLevel: AnxietyLevel
    let pattern: BreathingPattern
    @Binding var sessionComplete: Bool
    
    @State private var timeRemaining: Int = 0
    @State private var scale: CGFloat = 0.8
    @State private var phase: Phase = .inhale
    
    enum Phase {
        case inhale, hold, exhale
    }
    
    var phaseText: String {
        switch phase {
        case .inhale: return "Inhale confidence"
        case .hold: return "Hold steady"
        case .exhale: return "Exhale the fear"
        }
    }
    
    var phaseDuration: Double {
        switch phase {
        case .inhale: return pattern.inhale
        case .hold: return pattern.hold
        case .exhale: return pattern.exhale
        }
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(phaseText)
                .font(.title2.bold())
                .foregroundColor(.white)
                .padding(.bottom, 60)
            
            Circle()
                .fill(
                    RadialGradient(
                        colors: [.white, scenario.color.opacity(0.6)],
                        center: .center,
                        startRadius: 10,
                        endRadius: 160
                    )
                )
                .frame(width: 220, height: 220)
                .scaleEffect(scale)
                .shadow(color: scenario.color.opacity(0.6), radius: 30)
            
            Spacer()
            
            Text("\(timeRemaining)s")
                .foregroundColor(.white.opacity(0.8))
                .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                colors: [scenario.color.opacity(0.9), .black],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        
        
        .onAppear {
            timeRemaining = selectedLevel.duration
            SoundManager.shared.playBackground()
            startTimer()
            breathe()
        }
        .onDisappear {
            SoundManager.shared.stopBackground()
        }
    }
    
    // MARK: - Timer
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                sessionComplete = true
            }
        }
    }
    
    // MARK: - Breathing Loop
    
    func breathe() {
        
        // 📳 Haptic feedback synced to inhale
        HapticManager.shared.playBreathingPulse(expanding: phase == .inhale)
        
        // 🎬 Animate orb
        withAnimation(.easeInOut(duration: phaseDuration)) {
            switch phase {
            case .inhale:
                scale = 1.1
            case .hold:
                scale = 1.1
            case .exhale:
                scale = 0.8
            }
        }
        
        // Move to next phase
        DispatchQueue.main.asyncAfter(deadline: .now() + phaseDuration) {
            
            switch phase {
            case .inhale:
                phase = pattern.hold > 0 ? .hold : .exhale
            case .hold:
                phase = .exhale
            case .exhale:
                phase = .inhale
            }
            
            if timeRemaining > 0 {
                breathe()
            }
        }
    }
}
