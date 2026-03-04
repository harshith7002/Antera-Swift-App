import SwiftUI

struct PatternSelectionView: View {
    
    @Binding var selectedPattern: BreathingPattern
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.1, blue: 0.3), Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Header
                VStack(spacing: 8) {
                    Text("Choose Your Breath")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                    
                    Text("Pick what feels right for you right now")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 48)
                .padding(.bottom, 36)
                .padding(.horizontal, 24)
                
                // Pattern Cards
                VStack(spacing: 14) {
                    ForEach(BreathingPattern.allCases, id: \.self) { pattern in
                        PatternCard(
                            pattern: pattern,
                            isSelected: selectedPattern == pattern
                        ) {
                            withAnimation(.spring(response: 0.3)) {
                                selectedPattern = pattern
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Start Button
                Button {
                    onContinue()
                } label: {
                    Text("Start Breathing")
                        .font(.headline.bold())
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.white)
                        .cornerRadius(16)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 48)
            }
        }
    }
}
struct PatternCard: View {
    
    let pattern: BreathingPattern
    let isSelected: Bool
    let onTap: () -> Void
    
    var patternColor: Color {
        switch pattern {
        case .box: return .blue
        case .fourSevenEight: return .purple
        case .equal: return .green
        }
    }
    
    var patternIcon: String {
        switch pattern {
        case .box: return "square.fill"
        case .fourSevenEight: return "moon.stars.fill"
        case .equal: return "equal.circle.fill"
        }
    }
    
    var whatItMeans: String {
        switch pattern {
        case .box:
            return "In 4s  →  Hold 4s  →  Out 4s  →  Hold 4s"
        case .fourSevenEight:
            return "In 4s  →  Hold 7s  →  Out 8s"
        case .equal:
            return "In 5s  →  Out 5s"
        }
    }
    
    var whenToUse: String {
        switch pattern {
        case .box:
            return "Best for exam or interview focus"
        case .fourSevenEight:
            return "Best for high anxiety or racing heart"
        case .equal:
            return "Best for quick calm before speaking"
        }
    }
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                
                ZStack {
                    Circle()
                        .fill(isSelected
                              ? patternColor
                              : patternColor.opacity(0.15))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: patternIcon)
                        .foregroundColor(isSelected ? .white : patternColor)
                        .font(.title3)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(pattern.rawValue)
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(whatItMeans)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.6))
                    
                    Text(whenToUse)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.45))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ZStack {
                    Circle()
                        .fill(isSelected
                              ? patternColor
                              : Color.white.opacity(0.08))
                        .frame(width: 26, height: 26)
                    
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.caption.bold())
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(18)
            .background(
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color.white.opacity(isSelected ? 0.1 : 0.05))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18)
                            .stroke(
                                isSelected
                                ? patternColor
                                : Color.white.opacity(0.1),
                                lineWidth: 1.5
                            )
                    )
            )
            .shadow(
                color: isSelected
                ? patternColor.opacity(0.3)
                : .clear,
                radius: 10,
                x: 0,
                y: 4
            )
        }
    
    }
}
