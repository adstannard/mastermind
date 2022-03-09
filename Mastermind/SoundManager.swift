import AVKit
import SwiftUI

class SoundManager {
    
    static let instance = SoundManager()
    
    @AppStorage("sound") private var sound = DefaultSettings.sound
    
    var player: AVAudioPlayer?
    
    enum soundOption: String {
        case tap1
        case tap2
        case tap3
        case tap4
        case win
        case lose
        case reveal
        case hide
    }
    
    func playSound(soundEffect: soundOption) {
        guard let url = Bundle.main.url(forResource: soundEffect.rawValue, withExtension: ".mp3") else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            if (sound) {
                player?.play()
            }
        }
        catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}
