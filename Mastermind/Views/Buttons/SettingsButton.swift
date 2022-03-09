import SwiftUI

struct SettingsButton: View {
    
    var body: some View {
        Image(systemName: "gearshape.2")
            .resizable()
            .frame(width: 32, height: 25)
            .background(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.accentColor, lineWidth: 2)
                            .frame(width: 60, height: 50))
            .padding()
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton()
    }
}
