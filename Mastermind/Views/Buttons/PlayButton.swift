import SwiftUI

struct PlayButton: View {
    
    @Binding var isActive: Bool
    
    var body: some View {
        Image(systemName: "play")
            .resizable()
            .frame(width: 40, height: 40)
            .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .frame(width: 100, height: 100))
            .padding()
            .onTapGesture(perform: {
                // navigate to corresponding screen
                isActive = true
                
                // play tap sound
                SoundManager.instance.playSound(soundEffect: .tap5)
            })
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(isActive: Binding.constant(false))
    }
}
