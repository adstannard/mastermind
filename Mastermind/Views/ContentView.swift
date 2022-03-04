import SwiftUI

struct ContentView: View {
    
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    @State var isActive : Bool = false
    @State var sound: Bool = true
    @State var showNumbers: Bool = false
    @State var duplicateColors: Bool = true
    @State var timed: Bool = true
    @State var selectedRight: Bool = true
   
    
    var body: some View {
        NavigationView {
            ZStack {
                background.edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(destination:  DifficultiesView(rootIsActive: self.$isActive,
                                                                  sound: $sound,
                                                                  showNumbers: $showNumbers,
                                                                  duplicateColors: $duplicateColors,
                                                                  timed: $timed,
                                                                  selectedRight: $selectedRight),
                                   isActive: self.$isActive) {
                       PlayButton()
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView(sound: $sound,
                                                             showNumbers: $showNumbers,
                                                             duplicateColors: $duplicateColors,
                                                             timed: $timed,
                                                             selectedRight: $selectedRight)) {
                        Image(systemName: "gearshape.2")
                            .resizable()
                            .frame(width: 32, height: 25)
                            .background(RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.accentColor, lineWidth: 2)
                                            .frame(width: 60, height: 50))
                            .padding()
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
                            Text("MASTERMIND").font(.system(size: 30)).foregroundColor(.accentColor)
                        }
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.locale, Locale(identifier: "es"))
    }
}
