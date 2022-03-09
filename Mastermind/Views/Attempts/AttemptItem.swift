import SwiftUI

struct AttemptItem: View {
    
    @Binding var selected: Int
    @Binding var attempt: Int
    @Binding var position: Int
    @Binding var currentAttempt: Int
    @Binding var color: Color
    @Binding var content: String
    
    
    var body: some View {
        
        Button(action: {
            selected = position
            SoundManager.instance.playSound(soundEffect: .tap2)
        }){
            ColorButton(fill: $color,
                        stroke: (currentAttempt == attempt  && selected == position) ?
                        Binding.constant(Color.white) : color == Color.clear ?
                        Binding.constant(Color.gray): Binding.constant(Color.clear),
                        content: $content,
                        selected: Binding.constant(currentAttempt == attempt  && selected == position))
        }.padding(.top, 3)
        .disabled(currentAttempt != attempt)
    }
}


struct AttemptItem_Previews: PreviewProvider {
    static var previews: some View {
        AttemptItem(
            selected: Binding.constant(3),
            attempt: Binding.constant(3),
            position: Binding.constant(3),
            currentAttempt: Binding.constant(3),
            color:Binding.constant(Color.blue),
            content: Binding.constant("S")
        ).background(Color.black)
    }
}
