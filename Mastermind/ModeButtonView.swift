import SwiftUI

struct ModeButtonView: View {
    
    @Binding var difficulty: String
    @Binding var color: Color
    
    var body: some View {
        Text(difficulty)
            .font(.title)
            .frame(width: 100,height: 50)
            .foregroundColor(color)
            .padding()
            .background(RoundedRectangle(cornerRadius: 4).stroke(color, lineWidth: 2))
    }
}

struct ModeButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ModeButtonView(difficulty: Binding.constant("Hard"),
                       color: Binding.constant(Color.red))
    }
}
