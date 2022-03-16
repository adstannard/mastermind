import SwiftUI

struct SettingsButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Image(systemName: "gearshape.2")
            .resizable()
            .frame(width: 32, height: 25)
            .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .frame(width: 60, height: 50))
            .padding()
            .onTapGesture(perform: {
                // navigate to corresponding screen
                isActive = true
                
                // play tap sound
                SoundManager.instance.playSound(soundEffect: .tap5)
            })
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(isActive: Binding.constant(false))
    }
}
