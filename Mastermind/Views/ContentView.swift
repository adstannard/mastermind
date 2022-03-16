import SwiftUI

struct ContentView: View {
    
    @State var isActiveDifficulties : Bool = false
    @State var isActiveSettings : Bool = false
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // background
                Color.theme.background.edgesIgnoringSafeArea(.all)
                
                VStack () {
                    Spacer()
                    
                    // Play Game
                    NavigationLink(destination: DifficultiesView(rootIsActive: self.$isActiveDifficulties),
                                   isActive: self.$isActiveDifficulties) {
                        PlayButton(isActive: self.$isActiveDifficulties)
                    }
                    Spacer()
                    
                    // Game Settings
                    NavigationLink(destination: SettingsView(),
                                   isActive: self.$isActiveSettings) {
                        SettingsButton(isActive: self.$isActiveSettings)
                    }
                }
                .zIndex(2)
                .foregroundColor(.accentColor)
                .padding()
                .font(.title2)
                // .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .toolbar {
                    // screen title
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("MASTERMIND")
                                .font(.system(size: 30))
                                .foregroundColor(.accentColor)
                        }
                    }
                }
            }
        }
    }
}


// Default app settings
enum DefaultSettings {
    static let sound = true
    static let showNumbers = false
    static let duplicateColors = true
    static let timed = true
    static let selectedRight = true
    static let peek = false
}


// App constants
enum Constants {
    static let colors = [Color.red, Color.orange, Color.blue, Color.green, Color.theme.yellow, Color.purple, Color.mint, Color.white]
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.locale, Locale(identifier: "en"))
    }
}
