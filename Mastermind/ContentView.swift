import SwiftUI

struct ContentView: View {
    
    @State var sound: Bool = true
    @State var showNumbers: Bool = false
    @State var duplicateColors: Bool = true
    @State var timed: Bool = false
    @State var selectedRight: Bool = true
    
    
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    
    func generateRandom(size: Int, max: Int) -> [Int] {
        (0..<size).map( {_ in Int.random(in: 0..<max)} )
    }
    
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
        
        NavigationView {
            ZStack {
                
                Rectangle().foregroundColor(background).ignoresSafeArea()
                
                VStack{
                    Spacer()
                    NavigationLink(destination: GameView(difficulty: Binding.constant(Difficulty(maxAttempts: 8, codeSize: 4, numColors: 6)), ran: Binding.constant(duplicateColors ? generateRandom(size: 4, max: 6) : generateUniqueRandom(size: 4, max: 6)), selectedRight: $selectedRight, showNumbers: $showNumbers)) {
                        ModeButtonView(difficulty: Binding.constant("Easy"), color: Binding.constant(.green))
                    }
                    Spacer()
                    NavigationLink(destination: GameView(difficulty: Binding.constant(Difficulty(maxAttempts: 10, codeSize: 5, numColors: 7)), ran: Binding.constant(duplicateColors ? generateRandom(size: 5, max: 7) : generateUniqueRandom(size: 5, max: 7)), selectedRight: $selectedRight, showNumbers: $showNumbers)) {
                        ModeButtonView(difficulty: Binding.constant("Medium"), color: Binding.constant(.orange))
                    }
                    Spacer()
                    NavigationLink(destination: GameView(difficulty: Binding.constant(Difficulty(maxAttempts: 12, codeSize:6, numColors: 8)), ran: Binding.constant(duplicateColors ? generateRandom(size: 6, max: 8) : generateUniqueRandom(size: 6, max: 8)), selectedRight: $selectedRight, showNumbers: $showNumbers)) {
                        ModeButtonView(difficulty: Binding.constant("Hard"), color: Binding.constant(.red))}
                    
                    
                    Spacer()
                    NavigationLink(destination: SettingsView(sound: $sound, showNumbers: $showNumbers, duplicateColors: $duplicateColors, timed: $timed, selectedRight: $selectedRight)){
                        Image(systemName: "gearshape.2.fill")
                            .resizable()
                            .frame(width: 40, height: 32).background(RoundedRectangle(cornerRadius: 4).stroke(Color.accentColor, lineWidth: 2).frame(width: 70, height: 60))
                    }
                    Spacer()
                }
                .offset(y:-60)
            }
        }
    }
}

struct Difficulty {
    var maxAttempts: Int
    var codeSize: Int
    var numColors: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
