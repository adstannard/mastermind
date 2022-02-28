import SwiftUI

struct DifficultiesView: View {
    
    @Binding var sound: Bool
    @Binding var showNumbers: Bool
    @Binding var duplicateColors: Bool
    @Binding var timed: Bool
    @Binding var selectedRight: Bool
    @Binding var selectedEnglish: Bool
    
    private let difficulties = [
        Difficulty(maxAttempts: 8, codeSize: 4, numColors: 6, difficulty: "Easy", color: .green),
        Difficulty(maxAttempts: 10, codeSize: 5, numColors: 7, difficulty: "Medium", color: .orange),
        Difficulty(maxAttempts: 12, codeSize: 6, numColors: 8, difficulty: "Hard", color: .red)
    ]
    
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
                    GameModeLink(sound: $sound,
                                 showNumbers: $showNumbers,
                                 duplicateColors: $duplicateColors,
                                 timed: $timed,
                                 selectedRight: $selectedRight,
                                 selectedEnglish: $selectedEnglish,
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
                        Text("Select Difficulty").font(.system(size: 30)).foregroundColor(.accentColor)
                    }
                }
                ToolbarItem(placement: .automatic) {
                    VStack {
                        NavigationLink(destination: SettingsView(sound: $sound, showNumbers: $showNumbers, duplicateColors: $duplicateColors, timed: $timed, selectedRight: $selectedRight, selectedEnglish: $selectedEnglish)) {
                            Image(systemName: "gearshape")
                        }
                    }
                }
            }
        }
    }
}


struct DifficultiesView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultiesView(sound: Binding.constant(true), showNumbers: Binding.constant(true), duplicateColors: Binding.constant(true), timed: Binding.constant(true), selectedRight: Binding.constant(true), selectedEnglish: Binding.constant(true))
    }
}
