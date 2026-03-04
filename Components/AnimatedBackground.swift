import SwiftUI

struct AnimatedBackground: View {
    
    var colors: [Color]
    @State private var animate = false
    
    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: animate ? .topLeading : .bottomTrailing,
            endPoint: animate ? .bottomTrailing : .topLeading
        )
        .ignoresSafeArea()
        .animation(
            .easeInOut(duration: 10)
            .repeatForever(autoreverses: true),
            value: animate
        )
        .onAppear {
            animate = true
        }
    }
}
