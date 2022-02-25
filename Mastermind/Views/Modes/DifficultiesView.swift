import SwiftUI

struct DifficultiesView: View {
    
    @State var sound: Bool = true
    @State var showNumbers: Bool = false
    @State var duplicateColors: Bool = true
    @State var timed: Bool = false
    @State var selectedRight: Bool = true
    

    
    private let difficulties = [
        Difficulty(maxAttempts: 8, codeSize: 4, numColors: 6, difficulty: "Easy", color: .green),
        Difficulty(maxAttempts: 10, codeSize: 5, numColors: 7, difficulty: "Medium", color: .orange),
        Difficulty(maxAttempts: 12, codeSize: 6, numColors: 8, difficulty: "Hard", color: .red)
    ]
    
    
    private let background = Color(red: 0.0, green: 0.2, blue: 0.2)
    
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
                                 difficulty: Binding.constant($0))
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
            }
        }
    }
}

struct DifficultiesView_Previews: PreviewProvider {
    static var previews: some View {
        DifficultiesView()
    }
}
