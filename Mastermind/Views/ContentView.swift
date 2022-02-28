import SwiftUI

struct ContentView: View {
    
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    
    @State var sound: Bool = true
    @State var showNumbers: Bool = false
    @State var duplicateColors: Bool = true
    @State var timed: Bool = false
    @State var selectedRight: Bool = true
    @State var selectedEnglish: Bool = true
    @State private var wave = true
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle().foregroundColor(background).ignoresSafeArea()
                VStack {
                    Spacer()
                    NavigationLink(destination:  DifficultiesView(sound: $sound, showNumbers: $showNumbers, duplicateColors: $duplicateColors, timed: $timed, selectedRight: $selectedRight, selectedEnglish: $selectedEnglish)) {
                        Image(systemName: "play")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .background(RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.accentColor, lineWidth: 2)
                                            .frame(width: 100, height: 100))
                            .padding()
                            .opacity(wave ? 1 : 0.3)
                            .onAppear() {
                                self.wave.toggle()
                                withAnimation(
                                    .easeInOut(duration: 1)
                                        .repeatForever(autoreverses: true)
                                        .speed(1.5)) {
                                            self.wave.toggle()
                                        }
                            }
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView(sound: $sound,
                                                             showNumbers: $showNumbers,
                                                             duplicateColors: $duplicateColors,
                                                             timed: $timed,
                                                             selectedRight: $selectedRight, selectedEnglish: $selectedEnglish)) {
                        Image(systemName: "gearshape.2")
                            .resizable()
                            .frame(width: 32, height: 25)
                            .background(RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color.accentColor, lineWidth: 2)
                                            .frame(width: 60, height: 50))
                            .padding()
                    }
                }
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
        ContentView()
    }
}
