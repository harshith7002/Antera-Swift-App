import SwiftUI

struct BreathingOrb: View {
    var color: Color
    var scale: CGFloat
    
    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    colors: [
                        .white,
                        color.opacity(0.4)
                    ],
                    center: .center,
                    startRadius: 20,
                    endRadius: 200
                )
            )
            .frame(width: 200, height: 200)
            .scaleEffect(scale)
            .shadow(color: color.opacity(0.6), radius: 40)
    }
}
