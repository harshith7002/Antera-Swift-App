import SwiftUI

struct ScenarioSelectionView: View {
    
    @Binding var selectedScenario: Scenario?
    @State private var animateBackground = false
    @StateObject private var quoteService = QuoteService()
    @EnvironmentObject var store: SessionStore
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                LinearGradient(
                    colors: [Color.black, Color.gray.opacity(0.6), Color.black],
                    startPoint: animateBackground ? .topLeading : .bottomTrailing,
                    endPoint: animateBackground ? .bottomTrailing : .topLeading
                )
                .ignoresSafeArea()
                .animation(
                    .easeInOut(duration: 12)
                    .repeatForever(autoreverses: true),
                    value: animateBackground
                )
                
                RadialGradient(
                    colors: [Color.white.opacity(0.05), Color.clear],
                    center: .top,
                    startRadius: 50,
                    endRadius: 400
                )
                .ignoresSafeArea()
                
                VStack(spacing: 28) {
                    
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Image(systemName: "quote.opening")
                            .foregroundColor(.white.opacity(0.4))
                        
                        Text(quoteService.currentQuote.text)
                            .font(.body.italic())
                            .foregroundColor(.white.opacity(0.85))
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .padding(.horizontal)
                        
                        Text("— \(quoteService.currentQuote.author)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.5))
                    }
                    .padding(22)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white.opacity(0.08))
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.white.opacity(0.15))
                            )
                    )
                    .padding(.horizontal, 24)
                    
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Text("Before It Begins")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                        
                        Text("Choose your moment")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        scenarioButton("Exam", icon: "doc.text.fill", color: .blue)
                        scenarioButton("Presentation", icon: "mic.fill", color: .purple)
                        scenarioButton("Interview", icon: "briefcase.fill", color: .green)
                    }
                    .padding(.horizontal, 28)
                    
                    Spacer()
                }
                
                // ✅ Fixed History Navigation
                VStack {
                    HStack {
                        Spacer()
                        
                        NavigationLink {
                            HistoryView()   // FIXED
                        } label: {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color.white.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .onAppear {
                animateBackground = true
            }
        }
    }
    
    // MARK: - Scenario Button
    
    private func scenarioButton(_ title: String,
                                icon: String,
                                color: Color) -> some View {
        
        Button {
            // ❌ Removed SoundManager
            HapticManager.shared.playBreathingPulse(expanding: true)
            
            withAnimation(.easeInOut(duration: 0.25)) {
                selectedScenario = Scenario(name: title, color: color)
            }
            
        } label: {
            HStack(spacing: 14) {
                
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(color.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(0.08))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(Color.white.opacity(0.15))
                    )
            )
        }
    }
}
