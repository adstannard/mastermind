import SwiftUI

struct ModeButton: View {
    
    @Binding var difficulty: String
    @Binding var color: Color
    @Binding var isActive: Bool
    
    var body: some View {
        Text(LocalizedStringKey(difficulty))
            .font(.title)
            .frame(width: 100, height: 50)
            .foregroundColor(color)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(color, lineWidth: 2))
            .onTapGesture(
                perform: {
                    // navigate to corresponding screen
                    isActive = true
                    
                    // play tap sound
                    SoundManager.instance.playSound(soundEffect: .tap5)
                }
            )
    }
}

struct ModeButton_Previews: PreviewProvider {
    static var previews: some View {
        ModeButton(difficulty: Binding.constant("Hard"),
                   color: Binding.constant(Color.blue),
                   isActive: Binding.constant(false))
            .environment(\.locale, Locale(identifier: "en"))
    }
}
