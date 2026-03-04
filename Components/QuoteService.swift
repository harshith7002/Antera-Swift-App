import Foundation

struct Quote {
    let text: String
    let author: String
}

class QuoteService: ObservableObject {
    
    @Published var currentQuote: Quote
    
    private let quotes: [Quote] = [
        
        Quote(text: "Calm mind brings inner strength and confidence.", author: "Dalai Lama"),
        Quote(text: "You are braver than you believe.", author: "A.A. Milne"),
        Quote(text: "The present moment is the only moment available to us.", author: "Thich Nhat Hanh")
    ]
    
    init() {
        let index = Int.random(in: 0..<quotes.count)
        currentQuote = quotes[index]
    }
}

