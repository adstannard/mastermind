import SwiftUI

struct DifficultiesView: View {
    @Binding var rootIsActive: Bool
    @State var isSettingsActive: Bool = false
    
    @AppStorage("sound") private var sound = DefaultSettings.sound
    @AppStorage("showNumbers") private var showNumbers = DefaultSettings.showNumbers
    @AppStorage("duplicateColors") private var duplicateColors = DefaultSettings.duplicateColors
    @AppStorage("timed") private var timed = DefaultSettings.timed
    @AppStorage("selectedRight") private var selectedRight = DefaultSettings.selectedRight
    
    // difficulties array
    private let difficulties = [
        Difficulty(maxAttempts: 8, codeSize: 4, numColors: 6, difficulty: "Easy", color: .green),
        Difficulty(maxAttempts: 10, codeSize: 5, numColors: 7, difficulty: "Medium", color: .orange),
        Difficulty(maxAttempts: 12, codeSize: 6, numColors: 8, difficulty: "Hard", color: .red)
    ]
    
    // screen background
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    
    // generate random code (repetition allowed)
    func generateRandom(size: Int, max: Int) -> [Int] {
        (0..<size).map( {_ in Int.random(in: 0..<max)} )
    }
    
    // generate random code (unique values only)
    func generateUniqueRandom(size: Int, max: Int) -> [Int] {
        precondition(size < max, "Cannot generate a list of \(size) unique numbers, if they all have to be less than \(max)")
        
        var set = Set<Int>()
        var array = [Int]()
        
        while set.count < size {
            let randomNumber = Int.random(in: 0..<max)
            if (set.insert(randomNumber).inserted){
                array.append(randomNumber)
            }
        }
        return array
    }
    
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(background).ignoresSafeArea()
            VStack{
                Spacer()
                ForEach(difficulties, id: \.self) {
                    GameModeLink(shouldPopToRootView: $rootIsActive,
                                 difficulty: Binding.constant($0),
                                 ran: Binding.constant(duplicateColors ? generateRandom(size: $0.codeSize, max: $0.numColors) : generateUniqueRandom(size: $0.codeSize, max: $0.numColors)))
                    Spacer()
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
                        Text("Game Modes").font(.system(size: 30)).foregroundColor(.accentColor)
                    }
                }
                ToolbarItem(placement: .automatic) {
                    VStack {
                        NavigationLink(destination: SettingsView(), isActive:self.$isSettingsActive) {
                            Image(systemName: "gearshape")
                                .onTapGesture {
                                    isSettingsActive = true
                                    SoundManager.instance.playSound(soundEffect: .tap4)
                                }
                        }
                    }
                }
            }
        }
    }
}


struct DifficultiesView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultiesView(rootIsActive: Binding.constant(false)).environment(\.locale, Locale(identifier: "es"))
    }
}
