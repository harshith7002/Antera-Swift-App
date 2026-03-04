import AVFoundation

class SoundManager {
    
    static let shared = SoundManager()
    
    private var backgroundPlayer: AVAudioPlayer?
    private var tapPlayer: AVAudioPlayer?
    
    // MARK: - Background Music
    
    func playBackground() {
        guard let url = Bundle.main.url(forResource: "only-of-smooth-mp3", withExtension: "mp3") else {
            print("Background audio file not found")
            return
        }
        
        do {
            backgroundPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundPlayer?.numberOfLoops = -1
            backgroundPlayer?.volume = 0.4
            backgroundPlayer?.prepareToPlay()
            backgroundPlayer?.play()
        } catch {
            print("Background audio failed: \(error)")
        }
    }
    
    func stopBackground() {
        backgroundPlayer?.stop()
    }
}
