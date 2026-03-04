import CoreHaptics

class HapticManager {
    
    static let shared = HapticManager()
    private var engine: CHHapticEngine?
    
    init() {
        prepareEngine()
    }
    
    private func prepareEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine failed: \(error)")
        }
    }
    
    func playBreathingPulse(expanding: Bool) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics,
              let engine else { return }
        
        let intensity = CHHapticEventParameter(
            parameterID: .hapticIntensity,
            value: expanding ? 0.8 : 0.3
        )
        
        let sharpness = CHHapticEventParameter(
            parameterID: .hapticSharpness,
            value: expanding ? 0.2 : 0.6
        )
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensity, sharpness],
            relativeTime: 0,
            duration: 4.0
        )
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Haptic play failed: \(error)")
        }
    }
}
