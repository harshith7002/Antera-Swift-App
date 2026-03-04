import SwiftUI

struct ConfettiBurst: View {
    
    @State private var particles: [ConfettiParticle] = []
    
    struct ConfettiParticle: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var color: Color
        var rotation: Double
        var scale: CGFloat
        var opacity: Double
    }
    
    let colors: [Color] = [.yellow, .green, .blue, .pink, .orange, .purple]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { p in
                    Circle()
                        .fill(p.color)
                        .frame(width: 10, height: 10)
                        .scaleEffect(p.scale)
                        .opacity(p.opacity)
                        .position(x: p.x, y: p.y)
                        .rotationEffect(.degrees(p.rotation))
                }
            }
            .onAppear {
                burst(size: geo.size)
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
    }
    
    private func burst(size: CGSize) {
        let center = CGPoint(x: size.width / 2,
                             y: size.height / 2)
        
        particles = (0..<60).map { _ in
            ConfettiParticle(
                x: center.x,
                y: center.y,
                color: colors.randomElement()!,
                rotation: Double.random(in: 0...360),
                scale: CGFloat.random(in: 0.5...1.5),
                opacity: 1.0
            )
        }
        
        withAnimation(.easeOut(duration: 1.5)) {
            for i in particles.indices {
                particles[i].x = CGFloat.random(in: 0...size.width)
                particles[i].y = CGFloat.random(in: 0...size.height)
                particles[i].rotation = Double.random(in: 0...720)
                particles[i].opacity = 0
                particles[i].scale = CGFloat.random(in: 0.1...0.8)
            }
        }
    }
}
