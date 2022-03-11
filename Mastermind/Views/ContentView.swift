import SwiftUI

struct ContentView: View {
    
    @State var isActive : Bool = false
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // background
                Color.theme.background.edgesIgnoringSafeArea(.all)
                
                VStack () {
                    Spacer()
                    
                    // Play Game
                    NavigationLink(destination: DifficultiesView(rootIsActive: self.$isActive),
                                   isActive: self.$isActive) {
                        PlayButton(isActive: self.$isActive)
                    }
                    Spacer()
                    
                    // Game Settings
                    NavigationLink(destination: SettingsView(), tag: 1, selection: $action) {
                        EmptyView()
                    }
                    SettingsButton()
                        .onTapGesture {
                            // navigate to settings
                            self.action = 1
                            
                            // play tap sound
                            SoundManager.instance.playSound(soundEffect: .tap5)
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
