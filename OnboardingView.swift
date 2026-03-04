import SwiftUI

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
    let color: Color
}

struct OnboardingView: View {
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @State private var currentPage = 0
    @State private var done = false
    @State private var offset: CGFloat = 0
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(
            icon: "brain.head.profile",
            title: "Anxiety Is Normal",
            description: "Before big moments, your brain activates stress — that's okay.",
            color: .purple
        ),
        OnboardingPage(
            icon: "lungs.fill",
            title: "Breathe To Reset",
            description: "Controlled breathing calms your body and sharpens your mind.",
            color: .blue
        ),
        OnboardingPage(
            icon: "bolt.heart.fill",
            title: "Show Up Ready",
            description: "Antera prepares you to face your moment with calm and courage.",
            color: .green
        )
    ]
    
    var body: some View {
        if done {
            ContentView()
        } else {
            GeometryReader { geo in
                let screenWidth = geo.size.width
                
                ZStack {
                    
                    pages[currentPage].color
                        .opacity(0.25)
                        .ignoresSafeArea()
                        .animation(.easeInOut(duration: 0.5), value: currentPage)
                    
                    LinearGradient(
                        colors: [Color.black.opacity(0.6), Color.black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 0) {
                        
                        Spacer()
                        
                        // Sliding pages
                        ZStack {
                            ForEach(0..<pages.count, id: \.self) { index in
                                PageCard(page: pages[index], screenWidth: screenWidth)
                                    .frame(width: screenWidth)
                                    .offset(x: (CGFloat(index - currentPage) * screenWidth) + offset)
                                    .animation(
                                        .spring(response: 0.45, dampingFraction: 0.85),
                                        value: currentPage
                                    )
                            }
                        }
                        .frame(width: screenWidth)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    offset = value.translation.width * 0.4
                                }
                                .onEnded { value in
                                    offset = 0
                                    if value.translation.width < -50 {
                                        goNext()
                                    } else if value.translation.width > 50 {
                                        goPrev()
                                    }
                                }
                        )
                        
                        Spacer()
                        
                        // Dots
                        HStack(spacing: 10) {
                            ForEach(0..<pages.count, id: \.self) { i in
                                Capsule()
                                    .fill(i == currentPage
                                          ? Color.white
                                          : Color.white.opacity(0.3))
                                    .frame(
                                        width: i == currentPage ? 24 : 8,
                                        height: 8
                                    )
                                    .animation(.spring(), value: currentPage)
                            }
                        }
                        .padding(.bottom, 32)
                        
                        // Button
                        Button {
                            if currentPage < pages.count - 1 {
                                goNext()
                            } else {
                                hasSeenOnboarding = true
                                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                                UserDefaults.standard.synchronize()
                                done = true
                            }
                        } label: {
                            Text(currentPage == pages.count - 1 ? "Get Started" : "Next")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.black)
                                .cornerRadius(14)
                        }
                        .padding(.horizontal, screenWidth * 0.1)
                        .padding(.bottom, geo.safeAreaInsets.bottom + 32)
                    }
                }
            }
        }
    }
    
    func goNext() {
        if currentPage < pages.count - 1 {
            withAnimation { currentPage += 1 }
        }
    }
    
    func goPrev() {
        if currentPage > 0 {
            withAnimation { currentPage -= 1 }
        }
    }
}

struct PageCard: View {
    let page: OnboardingPage
    let screenWidth: CGFloat
    
    var body: some View {
        VStack(spacing: 28) {
            
            // Icon with glow
            ZStack {
                Circle()
                    .fill(page.color.opacity(0.2))
                    .frame(width: 130, height: 130)
                    .blur(radius: 20)
                
                Circle()
                    .fill(page.color.opacity(0.15))
                    .frame(width: 100, height: 100)
                
                Image(systemName: page.icon)
                    .font(.system(size: 52))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.white, page.color],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
            }
            
            VStack(spacing: 14) {
                Text(page.title)
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(page.description)
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.75))
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, screenWidth * 0.1)
        }
        .frame(width: screenWidth, alignment: .center)
        .padding(.vertical, 20)
    }
}
