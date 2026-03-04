import SwiftUI

struct FloatingParticles: View {
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            ForEach(0..<20, id: \.self) { _ in
                Circle()
                    .fill(Color.white.opacity(0.04))
                    .frame(width: CGFloat.random(in: 3...6))
                    .offset(
                        x: CGFloat.random(in: -150...150),
                        y: animate ? -350 : 350
                    )
                    .animation(
                        .linear(duration: Double.random(in: 8...14))
                        .repeatForever(autoreverses: false),
                        value: animate
                    )
            }
        }
        .onAppear {
            animate = true
        }
    }
}
