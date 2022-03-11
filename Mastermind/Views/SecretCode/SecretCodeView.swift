import SwiftUI

struct SecretCodeView: View {
    
    @Binding var difficulty: Difficulty
    @Binding var hidden: Bool
    @Binding var code: [Color]
    @Binding var ran: [Int]
    
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    @AppStorage("peek") private var peek = DefaultSettings.peek
    
    var body: some View {
        HStack(alignment: .center){
            // secret code
            ForEach(0..<difficulty.codeSize)  {
                // hide code if hidden
                if (hidden){
                    ColorButton(fill: Binding.constant(Color.clear),
                                stroke: Binding.constant(Color.gray),
                                content: Binding.constant("?"),
                                selected: Binding.constant(false))
                }
                // reveal code if not hidden
                else {
                    ColorButton(fill: Binding.constant(code[$0]),
                                stroke: Binding.constant(code[$0]),
                                content: Binding.constant(showNumbers ? String(ran[$0]+1) : ""),
                                selected: Binding.constant(false))
                }
            }
            
            // temporary button to reveal secret code
            if (peek) {
                Button(action: {
                    // tap sound effect
                    SoundManager.instance.playSound(soundEffect: hidden ? .reveal : .hide )
                    
                    // reveal/hide code
                    hidden.toggle()
                }){
                    Image(systemName: hidden ? "eye" : "eye.slash")
                }
            }
        }
    }
}

struct SecretCodeView_Previews: PreviewProvider {
    static var previews: some View {
        SecretCodeView(difficulty: Binding.constant(Difficulty(maxAttempts: 12,
                                                               codeSize: 6,
                                                               numColors: 8,
                                                               difficulty: "Easy",
                                                               color: .blue)),
                       hidden: Binding.constant(false),
                       code: Binding.constant([.red,.blue,.green,.green,.purple,.yellow]),
                       ran: Binding.constant([1, 0, 2, 2, 3, 6]))
    }
}
