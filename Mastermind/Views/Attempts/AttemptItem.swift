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
        }){
            ColorButton(fill: $color,
                            stroke: (currentAttempt == attempt  && selected == position) ?
                            Binding.constant(Color.white) : color == Color.clear ?
                            Binding.constant(Color.gray): Binding.constant(Color.clear),
                            content: $content,
                            selected: Binding.constant(currentAttempt == attempt  && selected == position))
        }
        .disabled(currentAttempt != attempt)
        .foregroundColor(Color(red: 0.0, green: 0.2, blue: 0.2))
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
