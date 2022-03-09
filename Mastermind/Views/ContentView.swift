import SwiftUI

struct ContentView: View {
    
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    @State var isActive : Bool = false
    
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            
            ZStack {
                background.edgesIgnoringSafeArea(.all)
                VStack () {
                    Spacer()
                    NavigationLink(destination: DifficultiesView(rootIsActive: self.$isActive),
                                   isActive: self.$isActive) {
                        PlayButton(isActive: self.$isActive)
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView(), tag: 1, selection: $action) {
                        EmptyView()
                    }
                    SettingsButton()
                        .onTapGesture {
                            self.action = 1
                            SoundManager.instance.playSound(soundEffect: .tap4)
                        }
                }
                .zIndex(2)
                .foregroundColor(.accentColor)
                .padding()
                .font(.title2)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("")
                .toolbar {
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


enum DefaultSettings {
    static let sound = true
    static let showNumbers = false
    static let duplicateColors = true
    static let timed = true
    static let selectedRight = true
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.locale, Locale(identifier: "es"))
    }
}
