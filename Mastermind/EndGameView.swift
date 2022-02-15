import SwiftUI

struct EndGameView: View {

    @Binding var show: Bool
    @Binding var message: String
    
    var body: some View {
        Text(message)
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView(show: Binding.constant(true), message: Binding.constant("YOU LOSE"))
    }
}
